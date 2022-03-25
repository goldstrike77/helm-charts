<!--- app-name: Apache Tomcat -->

# Apache Tomcat

Apache Tomcat is an open-source web server designed to host and run Java-based web applications. It is a lightweight server with a good performance for applications running in production environments.

[Overview of Apache Tomcat](http://tomcat.apache.org/)
                         
## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure
- ReadWriteMany volumes for deployment scaling

## Installing the Chart

To install the chart with the release name `tomcat`:

```console
$ helm install tomcat .
```

These commands deploy Tomcat on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `tomcat` deployment:

```console
$ helm delete tomcat
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`  |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`  |
| `global.storageClass`     | Global StorageClass for Persistent Volume(s)    | `""`  |


### Common parameters

| Name                | Description                                                                                  | Value           |
| ------------------- | -------------------------------------------------------------------------------------------- | --------------- |
| `kubeVersion`       | Force target Kubernetes version (using Helm capabilities if not set)                         | `""`            |
| `nameOverride`      | String to partially override common.names.fullname template (will maintain the release name) | `""`            |
| `fullnameOverride`  | String to fully override common.names.fullname template                                      | `""`            |
| `commonLabels`      | Add labels to all the deployed resources                                                     | `{}`            |
| `commonAnnotations` | Add annotations to all the deployed resources                                                | `{}`            |
| `clusterDomain`     | Kubernetes Cluster Domain                                                                    | `cluster.local` |
| `extraDeploy`       | Array of extra objects to deploy with the release                                            | `[]`            |


### Tomcat parameters

| Name                          | Description                                                          | Value                   |
| ----------------------------- | -------------------------------------------------------------------- | ----------------------- |
| `image.registry`              | Tomcat image registry                                                | `registry.cn-hangzhou.aliyuncs.com`             |
| `image.repository`            | Tomcat image repository                                              | `goldstrike/tomcat`        |
| `image.tag`                   | Tomcat image tag      | `8.5.77` |
| `image.pullPolicy`            | Tomcat image pull policy                                             | `IfNotPresent`          |
| `image.pullSecrets`           | Specify docker-registry secret names as an array                     | `[]`                    |
| `image.debug`                 | Specify if debug logs should be enabled                              | `false`                 |
| `hostAliases`                 | Deployment pod host aliases                                          | `[]`                    |
| `tomcatUsername`              | Tomcat admin user                                                    | `user`                  |
| `tomcatPassword`              | Tomcat admin password                                                | `""`                    |
| `tomcatAllowRemoteManagement` | Enable remote access to management interface                         | `0`                     |
| `catalinaOpts`                | Java runtime option used by tomcat JVM                               | `""`                    |
| `command`                     | Override default container command (useful when using custom images) | `[]`                    |
| `args`                        | Override default container args (useful when using custom images)    | `[]`                    |
| `extraEnvVars`                | Extra environment variables to be set on Tomcat container            | `[]`                    |
| `extraEnvVarsCM`              | Name of existing ConfigMap containing extra environment variables    | `""`                    |
| `extraEnvVarsSecret`          | Name of existing Secret containing extra environment variables       | `""`                    |


### Tomcat deployment parameters

| Name                                       | Description                                                                                                              | Value               |
| ------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------ | ------------------- |
| `replicaCount`                             | Specify number of Tomcat replicas                                                                                        | `1`                 |
| `deployment.type`                          | Use Deployment or StatefulSet                                                                                            | `deployment`        |
| `updateStrategy.type`                      | StrategyType                                                                                                             | `RollingUpdate`     |
| `containerPorts.http`                      | HTTP port to expose at container level                                                                                   | `8080`              |
| `containerExtraPorts`                      | Extra ports to expose at container level                                                                                 | `{}`                |
| `podSecurityContext.enabled`               | Enable Tomcat pods' Security Context                                                                                     | `true`              |
| `podSecurityContext.fsGroup`               | Set Tomcat pod's Security Context fsGroup                                                                                | `1001`              |
| `containerSecurityContext.enabled`         | Enable Tomcat containers' SecurityContext                                                                                | `true`              |
| `containerSecurityContext.runAsUser`       | User ID for the Tomcat container                                                                                         | `1001`              |
| `containerSecurityContext.runAsNonRoot`    | Force user to be root in Tomcat container                                                                                | `true`              |
| `resources.limits`                         | The resources limits for the Tomcat container                                                                            | `{}`                |
| `resources.requests`                       | The requested resources for the Tomcat container                                                                         | `{}`                |
| `livenessProbe.enabled`                    | Enable livenessProbe                                                                                                     | `true`              |
| `livenessProbe.initialDelaySeconds`        | Initial delay seconds for livenessProbe                                                                                  | `120`               |
| `livenessProbe.periodSeconds`              | Period seconds for livenessProbe                                                                                         | `10`                |
| `livenessProbe.timeoutSeconds`             | Timeout seconds for livenessProbe                                                                                        | `5`                 |
| `livenessProbe.failureThreshold`           | Failure threshold for livenessProbe                                                                                      | `6`                 |
| `livenessProbe.successThreshold`           | Success threshold for livenessProbe                                                                                      | `1`                 |
| `readinessProbe.enabled`                   | Enable readinessProbe                                                                                                    | `true`              |
| `readinessProbe.initialDelaySeconds`       | Initial delay seconds for readinessProbe                                                                                 | `30`                |
| `readinessProbe.periodSeconds`             | Period seconds for readinessProbe                                                                                        | `5`                 |
| `readinessProbe.timeoutSeconds`            | Timeout seconds for readinessProbe                                                                                       | `3`                 |
| `readinessProbe.failureThreshold`          | Failure threshold for readinessProbe                                                                                     | `3`                 |
| `readinessProbe.successThreshold`          | Success threshold for readinessProbe                                                                                     | `1`                 |
| `startupProbe.enabled`                     | Enable startupProbe                                                                                                      | `false`             |
| `startupProbe.initialDelaySeconds`         | Initial delay seconds for startupProbe                                                                                   | `30`                |
| `startupProbe.periodSeconds`               | Period seconds for startupProbe                                                                                          | `5`                 |
| `startupProbe.timeoutSeconds`              | Timeout seconds for startupProbe                                                                                         | `3`                 |
| `startupProbe.failureThreshold`            | Failure threshold for startupProbe                                                                                       | `3`                 |
| `startupProbe.successThreshold`            | Success threshold for startupProbe                                                                                       | `1`                 |
| `customLivenessProbe`                      | Override default liveness probe                                                                                          | `{}`                |
| `customReadinessProbe`                     | Override default readiness probe                                                                                         | `{}`                |
| `customStartupProbe`                       | Override default startup probe                                                                                           | `{}`                |
| `podLabels`                                | Extra labels for Tomcat pods                                                                                             | `{}`                |
| `podAnnotations`                           | Annotations for Tomcat pods                                                                                              | `{}`                |
| `podAffinityPreset`                        | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                      | `""`                |
| `podAntiAffinityPreset`                    | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                 | `soft`              |
| `nodeAffinityPreset.type`                  | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                | `""`                |
| `nodeAffinityPreset.key`                   | Node label key to match. Ignored if `affinity` is set.                                                                   | `""`                |
| `nodeAffinityPreset.values`                | Node label values to match. Ignored if `affinity` is set.                                                                | `[]`                |
| `affinity`                                 | Affinity for pod assignment. Evaluated as a template.                                                                    | `{}`                |
| `nodeSelector`                             | Node labels for pod assignment. Evaluated as a template.                                                                 | `{}`                |
| `schedulerName`                            | Alternative scheduler                                                                                                    | `""`                |
| `lifecycleHooks`                           | Override default etcd container hooks                                                                                    | `{}`                |
| `podManagementPolicy`                      | podManagementPolicy to manage scaling operation of pods (only in StatefulSet mode)                                       | `""`                |
| `tolerations`                              | Tolerations for pod assignment. Evaluated as a template.                                                                 | `[]`                |
| `topologySpreadConstraints`                | Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template | `[]`                |
| `extraPodSpec`                             | Optionally specify extra PodSpec                                                                                         | `{}`                |
| `extraVolumes`                             | Optionally specify extra list of additional volumes for Tomcat pods in Deployment                                        | `[]`                |
| `extraVolumeClaimTemplates`                | Optionally specify extra list of additional volume claim templates for Tomcat pods in StatefulSet                        | `[]`                |
| `extraVolumeMounts`                        | Optionally specify extra list of additional volumeMounts for Tomcat container(s)                                         | `[]`                |
| `initContainers`                           | Add init containers to the Tomcat pods.                                                                                  | `[]`                |
| `sidecars`                                 | Add sidecars to the Tomcat pods.                                                                                         | `[]`                |
| `persistence.enabled`                      | Enable persistence                                                                                                       | `true`              |
| `persistence.storageClass`                 | PVC Storage Class for Tomcat volume                                                                                      | `""`                |
| `persistence.annotations`                  | Persistent Volume Claim annotations                                                                                      | `{}`                |
| `persistence.accessModes`                  | PVC Access Modes for Tomcat volume                                                                                       | `["ReadWriteOnce"]` |
| `persistence.size`                         | PVC Storage Request for Tomcat volume                                                                                    | `8Gi`               |
| `persistence.existingClaim`                | An Existing PVC name for Tomcat volume                                                                                   | `""`                |
| `persistence.selectorLabels`               | Selector labels to use in volume claim template in statefulset                                                           | `{}`                |
| `networkPolicy.enabled`                    | Enable creation of NetworkPolicy resources. Only Ingress traffic is filtered for now.                                    | `false`             |
| `networkPolicy.allowExternal`              | Don't require client label for connections                                                                               | `true`              |
| `networkPolicy.explicitNamespacesSelector` | A Kubernetes LabelSelector to explicitly select namespaces from which traffic could be allowed                           | `{}`                |


### Traffic Exposure parameters

| Name                               | Description                                                                                                                      | Value                    |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| `service.type`                     | Kubernetes Service type                                                                                                          | `LoadBalancer`           |
| `service.ports.http`               | Service HTTP port                                                                                                                | `80`                     |
| `service.nodePorts.http`           | Kubernetes http node port                                                                                                        | `""`                     |
| `service.extraPorts`               | Extra ports to expose (normally used with the `sidecar` value)                                                                   | `[]`                     |
| `service.loadBalancerIP`           | Port Use serviceLoadBalancerIP to request a specific static IP, otherwise leave blank                                            | `""`                     |
| `service.clusterIP`                | Service Cluster IP                                                                                                               | `""`                     |
| `service.loadBalancerSourceRanges` | Service Load Balancer sources                                                                                                    | `[]`                     |
| `service.externalTrafficPolicy`    | Enable client source IP preservation                                                                                             | `Cluster`                |
| `service.annotations`              | Annotations for Tomcat service                                                                                                   | `{}`                     |
| `ingress.enabled`                  | Enable ingress controller resource                                                                                               | `false`                  |
| `ingress.hostname`                 | Default host for the ingress resource                                                                                            | `tomcat.local`           |
| `ingress.annotations`              | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations. | `{}`                     |
| `ingress.tls`                      | Enable TLS configuration for the hostname defined at `ingress.hostname` parameter                                                | `false`                  |
| `ingress.extraHosts`               | The list of additional hostnames to be covered with this ingress record.                                                         | `[]`                     |
| `ingress.extraTls`                 | The tls configuration for additional hostnames to be covered with this ingress record.                                           | `[]`                     |
| `ingress.extraPaths`               | Any additional arbitrary paths that may need to be added to the ingress under the main host.                                     | `[]`                     |
| `ingress.selfSigned`               | Create a TLS secret for this ingress record using self-signed certificates generated by Helm                                     | `false`                  |
| `ingress.ingressClassName`         | IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)                                                    | `""`                     |
| `ingress.secrets`                  | If you're providing your own certificates, please use this to add the certificates as secrets                                    | `[]`                     |
| `ingress.apiVersion`               | Force Ingress API version (automatically detected if not set)                                                                    | `""`                     |
| `ingress.path`                     | Ingress path                                                                                                                     | `/`                      |
| `ingress.pathType`                 | Ingress path type                                                                                                                | `ImplementationSpecific` |


### Volume Permissions parameters

| Name                                   | Description                                                                 | Value                   |
| -------------------------------------- | --------------------------------------------------------------------------- | ----------------------- |
| `volumePermissions.enabled`            | Enable init container that changes volume permissions in the data directory | `false`                 |
| `volumePermissions.image.registry`     | Init container volume-permissions image registry                            | `registry.cn-hangzhou.aliyuncs.com`             |
| `volumePermissions.image.repository`   | Init container volume-permissions image repository                          | `goldstrike/shell` |
| `volumePermissions.image.tag`          | Init container volume-permissions image tag                                 | `debian-10`     |
| `volumePermissions.image.pullPolicy`   | Init container volume-permissions image pull policy                         | `IfNotPresent`          |
| `volumePermissions.image.pullSecrets`  | Specify docker-registry secret names as an array                            | `[]`                    |
| `volumePermissions.resources.limits`   | Init container volume-permissions resource  limits                          | `{}`                    |
| `volumePermissions.resources.requests` | Init container volume-permissions resource  requests                        | `{}`                    |


### Metrics parameters

| Name                                      | Description                                                                                          | Value                                                                                                                                                                                                               |
| ----------------------------------------- | ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `metrics.enabled`                     | Whether or not to expose JMX metrics to Prometheus                                                   | `false`                                                                                                                                                                                                             |
| `metrics.catalinaOpts`                | custom option used to enabled JMX on tomcat jvm evaluated as template                                | `-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=5555 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.local.only=true` |
| `metrics.image.registry`              | JMX exporter image registry                                                                          | `registry.cn-hangzhou.aliyuncs.com`                                                                                                                                                                                                         |
| `metrics.image.repository`            | JMX exporter image repository                                                                        | `goldstrike/jmx-exporter`                                                                                                                                                                                              |
| `metrics.image.tag`                   | JMX exporter image tag              | `0.16.1`                                                                                                                                                                                             |
| `metrics.image.pullPolicy`            | JMX exporter image pull policy                                                                       | `IfNotPresent`                                                                                                                                                                                                      |
| `metrics.image.pullSecrets`           | Specify docker-registry secret names as an array                                                     | `[]`                                                                                                                                                                                                                |
| `metrics.config`                      | Configuration file for JMX exporter                                                                  | `""`                                                                                                                                                                                                                |
| `metrics.resources.limits`            | JMX Exporter container resource limits                                                               | `{}`                                                                                                                                                                                                                |
| `metrics.resources.requests`          | JMX Exporter container resource requests                                                             | `{}`                                                                                                                                                                                                                |
| `metrics.ports.metrics`               | JMX Exporter container metrics ports                                                                 | `5556`                                                                                                                                                                                                              |
| `metrics.existingConfigmap`           | Name of existing ConfigMap with JMX exporter configuration                                           | `""`                                                                                                                                                                                                                |
| `metrics.serviceMonitor.enabled`           | Creates a Prometheus Operator ServiceMonitor (also requires `metrics.enabled` to be `true`)                                               | `false`                  |
| `metrics.serviceMonitor.namespace`         | Namespace in which Prometheus is running                                                                                                  | `""`                     |
| `metrics.serviceMonitor.interval`          | Interval at which metrics should be scraped.                                                                                              | `""`                     |
| `metrics.serviceMonitor.scrapeTimeout`     | Timeout after which the scrape is ended                                                                                                   | `""`                     |
| `metrics.serviceMonitor.selector`          | Prometheus instance selector labels                                                                                                       | `{}`                     |
| `metrics.serviceMonitor.additionalLabels`  | Additional labels that can be used so PodMonitor will be discovered by Prometheus                                                         | `{}`                     |
| `metrics.serviceMonitor.relabelings`       | RelabelConfigs to apply to samples before scraping                                                                                        | `[]`                     |
| `metrics.serviceMonitor.metricRelabelings` | MetricRelabelConfigs to apply to samples before ingestion                                                                                 | `[]`                     |
| `metrics.prometheusRule.enabled`          | Set this to true to create prometheusRules for Prometheus operator                                   | `false`                                                                                                                                                                                                             |
| `metrics.prometheusRule.additionalLabels` | Additional labels that can be used so prometheusRules will be discovered by Prometheus               | `{}`                                                                                                                                                                                                                |
| `metrics.prometheusRule.namespace`        | namespace where prometheusRules resource should be created                                           | `""`                                                                                                                                                                                                                |
| `metrics.prometheusRule.rules`            | Create specified [Rules](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/) | `[]`                                                                                                                                                                                                                |
