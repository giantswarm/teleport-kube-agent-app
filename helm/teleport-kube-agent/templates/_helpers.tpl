{{/* Common labels */}}
{{- define "labels.common" -}}
app.kubernetes.io/name: {{ .Release.Name | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
application.giantswarm.io/team: {{ index .Chart.Annotations "application.giantswarm.io/team" | quote }}
{{- end }}

{{- define "teleport.kube.agent.isUpgrade" -}}
{{- /* Checks if action is an upgrade from an old release that didn't support Secret storage */}}
{{- if .Release.IsUpgrade }}
  {{- $deployment := (lookup "apps/v1" "Deployment"  .Release.Namespace .Release.Name ) -}}
  {{- if ($deployment) }}
true
  {{- else if .Values.unitTestUpgrade }}
true
  {{- end }}
{{- end }}
{{- end -}}
{{/*
Create the name of the service account to use
if serviceAccount is not defined or serviceAccount.name is empty, use .Release.Name
*/}}
{{- define "teleport-kube-agent.serviceAccountName" -}}
{{- coalesce .Values.serviceAccount.name .Values.serviceAccountName .Release.Name -}}
{{- end -}}

{{/*
Create the name of the service account to use for the post-delete hook
if serviceAccount is not defined or serviceAccount.name is empty, use .Release.Name-delete-hook
*/}}
{{- define "teleport-kube-agent.deleteHookServiceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- printf "%s-delete-hook" (include "teleport-kube-agent.serviceAccountName" . ) -}}
{{- else -}}
{{- (include "teleport-kube-agent.serviceAccountName" . ) -}}
{{- end -}}
{{- end -}}

{{- define "teleport-kube-agent.version" -}}
{{- if .Values.teleportVersionOverride -}}
  {{- .Values.teleportVersionOverride -}}
{{- else -}}
  {{- .Chart.AppVersion -}}
{{- end -}}
{{- end -}}

{{- define "teleport-kube-agent.baseImage" -}}
{{- if .Values.enterprise -}}
  {{- .Values.enterpriseImage -}}
{{- else -}}
  {{- .Values.image.repository -}}
{{- end -}}
{{- end -}}

{{- define "teleport-kube-agent.image" -}}
{{ include "teleport-kube-agent.baseImage" . }}:{{ include "teleport-kube-agent.version" . }}
{{- end -}}

{{- define "registry" }}
{{- $registry := .Values.image.registry -}}
{{- if and .Values.global (and .Values.global.image .Values.global.image.registry) -}}
{{- $registry = .Values.global.image.registry -}}
{{- end -}}
{{- printf "%s" $registry -}}
{{- end -}}
