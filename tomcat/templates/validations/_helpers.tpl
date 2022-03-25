{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper Tomcat image name
*/}}
{{- define "tomcat.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the Tomcat ports map
*/}}
{{- define "tomcat.ports" -}}
- port: {{ .Values.containerPort }}
  protocol: TCP
{{- range .Values.containerExtraPorts }}
- port: {{ include "common.tplvalues.render" (dict "value" .containerPort "context" $) }}
  protocol: TCP
{{- end }}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "tomcat.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end -}}

{{/*
Return the proper image name (for the init container volume-permissions image)
*/}}
{{- define "tomcat.volumePermissions.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.volumePermissions.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "tomcat.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.image .Values.volumePermissions.image .Values.metrics.image) "global" .Values.global) -}}
{{- end -}}

{{/*
Check if there are rolling tags in the images
*/}}
{{- define "tomcat.checkRollingTags" -}}
{{- include "common.warnings.rollingTag" .Values.image }}
{{- include "common.warnings.rollingTag" .Values.volumePermissions.image }}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "tomcat.pvc" -}}
{{- coalesce .Values.persistence.existingClaim (include "common.names.fullname" .) -}}
{{- end -}}

{{/*
Return the proper CATALINA_OPTS value
*/}}
{{- define "tomcat.catalinaOpts" -}}
{{- if .Values.metrics.enabled -}}
{{- default "" (cat .Values.catalinaOpts .Values.metrics.catalinaOpts) | trim  -}}
{{- else -}} 
{{- default "" .Values.catalinaOpts  | trim -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper JMX exporter image name
*/}}
{{- define "tomcat.metrics.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.metrics.image "global" .Values.global) -}}
{{- end -}}

{{/*
Return the tomcat jmx configuration configmap
*/}}
{{- define "tomcat.metrics.configmapName" -}}
{{- if .Values.metrics.existingConfigmap -}}
    {{- printf "%s" (tpl .Values.metrics.existingConfigmap $) -}}
{{- else -}}
    {{- printf "%s-jmx-configuration" (include "tomcat.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Compile all warnings into a single message, and call fail.
*/}}
{{- define "tomcat.validateValues" -}}
{{- $messages := list -}}
{{- $messages := append $messages (include "tomcat.validateValues.jmxConfig" .) -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}

{{- if $message -}}
{{- printf "\nVALUES VALIDATION:\n%s" $message | fail -}}
{{- end -}}
{{- end -}}

{{/*
Check if jmx metrics is enabled, then either metrics.config or metrics.existingConfigmap must be set.
*/}}
{{- define "tomcat.validateValues.jmxConfig" -}}
    {{- if and .Values.metrics.enabled (not .Values.metrics.config)  (not .Values.metrics.existingConfigmap) -}}
tomcat: metrics.enabled
    In order to enable JMX metrics, you also need to provide
    the prometheus/jmx_exporter configuration or
    provide an existing ConfigMap.
  {{- end -}}
{{- end -}}
