{{/* The Alluxio Open Foundation licenses this work under the Apache License, version 2.0
(the "License"). You may not use this work except in compliance with the License, which is
available at www.apache.org/licenses/LICENSE-2.0
This software is distributed on an "AS IS" basis, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
either express or implied, as more fully set forth in the License.
See the NOTICE file distributed with this work for information regarding copyright ownership. */}}

{{- define "alluxio-operator.image" -}}
{{- $registry := $.Values.global.azure.images.operator.registry }}
{{- $image := $.Values.global.azure.images.operator.image | default .Values.image }}
{{- $imageTag := $.Values.global.azure.images.operator.tag | default .Values.imageTag }}
{{- if not (and $image $imageTag) }}
{{ fail "Error: image and imageTag must be set" }}
{{- end }}
{{- printf "%s/%s:%s" $registry $image $imageTag }}
{{- end -}}

{{- define "alluxio-operator.imagePullSecrets" -}}
{{- include "common.imagePullSecrets" (dict "imagePullSecrets" .Values.global.imagePullSecrets | default .Values.imagePullSecrets) }}
{{- end -}}

# forward compatibility for okta auth type
{{- define "alluxio-operator.console.issuerURL" -}}
{{- if and (eq .Values.console.web.authType "okta") .Values.console.web.oktaIssuer }}
{{- .Values.console.web.oktaIssuer }}
{{- else }}
{{- .Values.console.web.issuerURL }}
{{- end }}
{{- end -}}

{{- define "alluxio-operator.console.clientID" -}}
{{- if and (eq .Values.console.web.authType "okta") .Values.console.web.oktaClientID }}
{{- .Values.console.web.oktaClientID }}
{{- else }}
{{- .Values.console.web.clientID }}
{{- end }}
{{- end -}}
