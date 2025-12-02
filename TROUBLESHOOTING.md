# Troubleshooting Teleport Kube Agent

## MC Bootstrap Flakiness Issue

### Problem Description

The Teleport Kube Agent has been causing MC (Management Cluster) Bootstrap to become flaky, with pods repeatedly entering a "degraded state" during cluster creation. This manifests as:

```
Detected Teleport component is running in a degraded state
Teleport component is recovering from a degraded state
```

These messages repeat continuously in the pod logs, indicating the agent is having difficulty establishing a stable connection to the Teleport proxy server.

### Root Cause Analysis

The flakiness is primarily caused by **insufficient time for the agent to establish initial connections** during fresh cluster deployment. Several factors contribute:

1. **Aggressive Probe Timing**: 
   - The original readiness probe gave only 60 seconds for the agent to connect
   - The liveness probe allowed only 30 seconds
   - During MC Bootstrap, DNS, networking, and the Teleport proxy connection all need time to stabilize
   - With 3 replicas running simultaneously, competition for resources and network connections can cause delays

2. **Short Probe Timeouts**:
   - The probe timeout was set to 1 second, which is too aggressive for network operations
   - In slow network conditions or during cluster initialization, probes could timeout before getting a response

3. **Fresh Cluster Conditions**:
   - During MC Bootstrap, many components are starting simultaneously
   - DNS resolution may be slow or unstable initially
   - Network policies are being applied
   - The Teleport proxy connection requires TLS handshake and authentication

### Solution

The fix involves making the health probes more lenient during initial startup while maintaining reasonable failure detection:

#### 1. Extended Readiness Probe Timing
- **Initial Delay**: Increased from 5s to 15s
- **Period**: Increased from 5s to 10s  
- **Failure Threshold**: Increased from 12 to 18 (180s total)
- **Result**: Gives the agent up to 3 minutes to establish connection instead of 1 minute

#### 2. Extended Liveness Probe Timing
- **Initial Delay**: Increased from 5s to 10s
- **Period**: Increased from 5s to 10s
- **Failure Threshold**: Remains at 6 (60s total)
- **Result**: Gives the agent 1 minute before considering it dead (doubled from 30s)

#### 3. Increased Probe Timeout
- **Timeout**: Increased from 1s to 5s
- **Result**: More resilient to slow network responses

### Changes Made

Files modified:
- `helm/teleport-kube-agent/templates/statefulset.yaml`
- `helm/teleport-kube-agent/templates/deployment.yaml`
- `helm/teleport-kube-agent/values.yaml`
- `CHANGELOG.md`

### Testing Recommendations

When testing this fix:

1. **MC Bootstrap**: Create a fresh management cluster and verify the Teleport agent pods reach ready state
2. **Monitor Pod Events**: Check for CrashLoopBackOff or readiness probe failures
3. **Check Logs**: Ensure "degraded state" messages are transient and resolve quickly
4. **Network Conditions**: Test in slower network environments if possible
5. **Multiple Deployments**: Run several MC Bootstrap cycles to verify consistency

### Additional Debugging

If issues persist after this fix, check:

1. **Teleport Proxy Status**: Verify test.teleport.giantswarm.io is reachable and healthy
2. **Network Policies**: Ensure no network policies are blocking agent-to-proxy communication
3. **DNS Resolution**: Check that DNS is working properly in the cluster
4. **Join Token**: Verify the join token is valid and has correct permissions
5. **Resource Constraints**: Check if pods are being throttled or OOMKilled
6. **Proxy Configuration**: Verify HTTP_PROXY/HTTPS_PROXY settings if using a proxy

### Related Configuration

Key configuration values that affect reliability:

```yaml
# Probe timeout for individual requests
probeTimeoutSeconds: 5

# Resources allocated to each pod
resources:
  requests:
    cpu: 100m
    memory: 256Mi
  limits:
    cpu: 1000m
    memory: 512Mi

# High availability settings
highAvailability:
  replicaCount: 3
  requireAntiAffinity: false
  podDisruptionBudget:
    enabled: true
    minAvailable: 1
```

### Contact

For issues or questions, contact Team Shield:
- Email: team-shield@giantswarm.io
- Slack: #team-shield

