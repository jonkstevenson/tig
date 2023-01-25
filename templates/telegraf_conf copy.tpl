# Telegraf Configuration
#
# Telegraf is entirely plugin driven. All metrics are gathered from the
# declared inputs, and sent to the declared outputs.
#
# Plugins must be declared in here to be active.
# To deactivate a plugin, comment out the name and any variables.
#
# Use 'telegraf -config telegraf.conf -test' to see what metrics a config
# file would generate.
#
# Environment variables can be used anywhere in this config file, simply surround
# them with ${}. For strings the variable must be within quotes (ie, "${STR_VAR}"),
# for numbers and booleans they should be plain (ie, ${INT_VAR}, ${BOOL_VAR})


# Global tags can be specified here in key="value" format.
[global_tags]
  # dc = "us-east-1" # will tag all metrics with dc=us-east-1
  # rack = "1a"
  ## Environment variables can be used as tags, and throughout the config file
  # user = "$USER"


# Configuration for telegraf agent
[agent]
  ## Default data collection interval for all inputs
  interval = "10s"
  ## Rounds collection interval to 'interval'
  ## ie, if interval="10s" then always collect on :00, :10, :20, etc.
  round_interval = true

  ## Telegraf will send metrics to outputs in batches of at most
  ## metric_batch_size metrics.
  ## This controls the size of writes that Telegraf sends to output plugins.
  metric_batch_size = 1000

  ## Maximum number of unwritten metrics per output.  Increasing this value
  ## allows for longer periods of output downtime without dropping metrics at the
  ## cost of higher maximum memory usage.
  metric_buffer_limit = 10000

  ## Collection jitter is used to jitter the collection by a random amount.
  ## Each plugin will sleep for a random time within jitter before collecting.
  ## This can be used to avoid many plugins querying things like sysfs at the
  ## same time, which can have a measurable effect on the system.
  collection_jitter = "0s"

  ## Collection offset is used to shift the collection by the given amount.
  ## This can be be used to avoid many plugins querying constraint devices
  ## at the same time by manually scheduling them in time.
  # collection_offset = "0s"

  ## Default flushing interval for all outputs. Maximum flush_interval will be
  ## flush_interval + flush_jitter
  flush_interval = "10s"
  ## Jitter the flush interval by a random amount. This is primarily to avoid
  ## large write spikes for users running a large number of telegraf instances.
  ## ie, a jitter of 5s and interval 10s means flushes will happen every 10-15s
  flush_jitter = "0s"

  ## Collected metrics are rounded to the precision specified. Precision is
  ## specified as an interval with an integer + unit (e.g. 0s, 10ms, 2us, 4s).
  ## Valid time units are "ns", "us" (or "µs"), "ms", "s".
  ##
  ## By default or when set to "0s", precision will be set to the same
  ## timestamp order as the collection interval, with the maximum being 1s:
  ##   ie, when interval = "10s", precision will be "1s"
  ##       when interval = "250ms", precision will be "1ms"
  ##
  ## Precision will NOT be used for service inputs. It is up to each individual
  ## service input to set the timestamp at the appropriate precision.
  precision = ""

  ## Log at debug level.
  # debug = false
  ## Log only error level messages.
  # quiet = false

  ## Log target controls the destination for logs and can be one of "file",
  ## "stderr" or, on Windows, "eventlog".  When set to "file", the output file
  ## is determined by the "logfile" setting.
  # logtarget = "file"

  ## Name of the file to be logged to when using the "file" logtarget.  If set to
  ## the empty string then logs are written to stderr.
  # logfile = ""

  ## The logfile will be rotated after the time interval specified.  When set
  ## to 0 no time based rotation is performed.  Logs are rotated only when
  ## written to, if there is no log activity rotation may be delayed.
  # logfile_rotation_interval = "0d"

  ## The logfile will be rotated when it becomes larger than the specified
  ## size.  When set to 0 no size based rotation is performed.
  # logfile_rotation_max_size = "0MB"

  ## Maximum number of rotated archives to keep, any older logs are deleted.
  ## If set to -1, no archives are removed.
  # logfile_rotation_max_archives = 5

  ## Pick a timezone to use when logging or type 'local' for local time.
  ## Example: America/Chicago
  # log_with_timezone = ""

  ## Override default hostname, if empty use os.Hostname()
  hostname = ""
  ## If set to true, do no set the "host" tag in the telegraf agent.
  omit_hostname = false

###############################################################################
#                            OUTPUT PLUGINS                                   #
###############################################################################


# Configuration for sending metrics to InfluxDB
# [[outputs.influxdb]]
  ## The full HTTP or UDP URL for your InfluxDB instance.
  ##
  ## Multiple URLs can be specified for a single cluster, only ONE of the
  ## urls will be written to each interval.
  # urls = ["unix:///var/run/influxdb.sock"]
  # urls = ["udp://127.0.0.1:8089"]
  # urls = ["http://127.0.0.1:8086"]

  ## The target database for metrics; will be created as needed.
  ## For UDP url endpoint database needs to be configured on server side.
  # database = "telegraf"

  ## The value of this tag will be used to determine the database.  If this
  ## tag is not set the 'database' option is used as the default.
  # database_tag = ""

  ## If true, the 'database_tag' will not be included in the written metric.
  # exclude_database_tag = false

  ## If true, no CREATE DATABASE queries will be sent.  Set to true when using
  ## Telegraf with a user without permissions to create databases or when the
  ## database already exists.
  # skip_database_creation = false

  ## Name of existing retention policy to write to.  Empty string writes to
  ## the default retention policy.  Only takes effect when using HTTP.
  # retention_policy = ""

  ## The value of this tag will be used to determine the retention policy.  If this
  ## tag is not set the 'retention_policy' option is used as the default.
  # retention_policy_tag = ""

  ## If true, the 'retention_policy_tag' will not be included in the written metric.
  # exclude_retention_policy_tag = false

  ## Write consistency (clusters only), can be: "any", "one", "quorum", "all".
  ## Only takes effect when using HTTP.
  # write_consistency = "any"

  ## Timeout for HTTP messages.
  # timeout = "5s"

  ## HTTP Basic Auth
  # username = "telegraf"
  # password = "metricsmetricsmetricsmetrics"

  ## HTTP User-Agent
  # user_agent = "telegraf"

  ## UDP payload size is the maximum packet size to send.
  # udp_payload = "512B"

  ## Optional TLS Config for use on HTTP connections.
  # tls_ca = "/etc/telegraf/ca.pem"
  # tls_cert = "/etc/telegraf/cert.pem"
  # tls_key = "/etc/telegraf/key.pem"
  ## Use TLS but skip chain & host verification
  # insecure_skip_verify = false

  ## HTTP Proxy override, if unset values the standard proxy environment
  ## variables are consulted to determine which proxy, if any, should be used.
  # http_proxy = "http://corporate.proxy:3128"

  ## Additional HTTP headers
  # http_headers = {"X-Special-Header" = "Special-Value"}

  ## HTTP Content-Encoding for write request body, can be set to "gzip" to
  ## compress body or "identity" to apply no encoding.
  # content_encoding = "gzip"

  ## When true, Telegraf will output unsigned integers as unsigned values,
  ## i.e.: "42u".  You will need a version of InfluxDB supporting unsigned
  ## integer values.  Enabling this option will result in field type errors if
  ## existing data has been written.
  # influx_uint_support = false


# # Configuration for Amon Server to send metrics to.
# [[outputs.amon]]
#   ## Amon Server Key
#   server_key = "my-server-key" # required.
#
#   ## Amon Instance URL
#   amon_instance = "https://youramoninstance" # required
#
#   ## Connection timeout.
#   # timeout = "5s"


# # Publishes metrics to an AMQP broker
# [[outputs.amqp]]
#   ## Brokers to publish to.  If multiple brokers are specified a random broker
#   ## will be selected anytime a connection is established.  This can be
#   ## helpful for load balancing when not using a dedicated load balancer.
#   brokers = ["amqp://localhost:5672/influxdb"]
#
#   ## Maximum messages to send over a connection.  Once this is reached, the
#   ## connection is closed and a new connection is made.  This can be helpful for
#   ## load balancing when not using a dedicated load balancer.
#   # max_messages = 0
#
#   ## Exchange to declare and publish to.
#   exchange = "telegraf"
#
#   ## Exchange type; common types are "direct", "fanout", "topic", "header", "x-consistent-hash".
#   # exchange_type = "topic"
#
#   ## If true, exchange will be passively declared.
#   # exchange_passive = false
#
#   ## Exchange durability can be either "transient" or "durable".
#   # exchange_durability = "durable"
#
#   ## Additional exchange arguments.
#   # exchange_arguments = { }
#   # exchange_arguments = {"hash_property" = "timestamp"}
#
#   ## Authentication credentials for the PLAIN auth_method.
#   # username = ""
#   # password = ""
#
#   ## Auth method. PLAIN and EXTERNAL are supported
#   ## Using EXTERNAL requires enabling the rabbitmq_auth_mechanism_ssl plugin as
#   ## described here: https://www.rabbitmq.com/plugins.html
#   # auth_method = "PLAIN"
#
#   ## Metric tag to use as a routing key.
#   ##   ie, if this tag exists, its value will be used as the routing key
#   # routing_tag = "host"
#
#   ## Static routing key.  Used when no routing_tag is set or as a fallback
#   ## when the tag specified in routing tag is not found.
#   # routing_key = ""
#   # routing_key = "telegraf"
#
#   ## Delivery Mode controls if a published message is persistent.
#   ##   One of "transient" or "persistent".
#   # delivery_mode = "transient"
#
#   ## Static headers added to each published message.
#   # headers = { }
#   # headers = {"database" = "telegraf", "retention_policy" = "default"}
#
#   ## Connection timeout.  If not provided, will default to 5s.  0s means no
#   ## timeout (not recommended).
#   # timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## If true use batch serialization format instead of line based delimiting.
#   ## Only applies to data formats which are not line based such as JSON.
#   ## Recommended to set to true.
#   # use_batch_format = false
#
#   ## Content encoding for message payloads, can be set to "gzip" to or
#   ## "identity" to apply no encoding.
#   ##
#   ## Please note that when use_batch_format = false each amqp message contains only
#   ## a single metric, it is recommended to use compression with batch format
#   ## for best results.
#   # content_encoding = "identity"
#
#   ## Data format to output.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_OUTPUT.md
#   # data_format = "influx"


# # Send metrics to Azure Application Insights
# [[outputs.application_insights]]
#   ## Instrumentation key of the Application Insights resource.
#   instrumentation_key = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx"
#
#   ## Regions that require endpoint modification https://docs.microsoft.com/en-us/azure/azure-monitor/app/custom-endpoints
#   # endpoint_url = "https://dc.services.visualstudio.com/v2/track"
#
#   ## Timeout for closing (default: 5s).
#   # timeout = "5s"
#
#   ## Enable additional diagnostic logging.
#   # enable_diagnostic_logging = false
#
#   ## Context Tag Sources add Application Insights context tags to a tag value.
#   ##
#   ## For list of allowed context tag keys see:
#   ## https://github.com/microsoft/ApplicationInsights-Go/blob/master/appinsights/contracts/contexttagkeys.go
#   # [outputs.application_insights.context_tag_sources]
#   #   "ai.cloud.role" = "kubernetes_container_name"
#   #   "ai.cloud.roleInstance" = "kubernetes_pod_name"


# # Sends metrics to Azure Data Explorer
# [[outputs.azure_data_explorer]]
#   ## Azure Data Explorer cluster endpoint
#   ## ex: endpoint_url = "https://clustername.australiasoutheast.kusto.windows.net"
#   endpoint_url = ""
#
#   ## The Azure Data Explorer database that the metrics will be ingested into.
#   ## The plugin will NOT generate this database automatically, it's expected that this database already exists before ingestion.
#   ## ex: "exampledatabase"
#   database = ""
#
#   ## Timeout for Azure Data Explorer operations
#   # timeout = "20s"
#
#   ## Type of metrics grouping used when pushing to Azure Data Explorer.
#   ## Default is "TablePerMetric" for one table per different metric.
#   ## For more information, please check the plugin README.
#   # metrics_grouping_type = "TablePerMetric"
#
#   ## Name of the single table to store all the metrics (Only needed if metrics_grouping_type is "SingleTable").
#   # table_name = ""
#
#   ## Creates tables and relevant mapping if set to true(default).
#   ## Skips table and mapping creation if set to false, this is useful for running Telegraf with the lowest possible permissions i.e. table ingestor role.
#   # create_tables = true


# # Send aggregate metrics to Azure Monitor
# [[outputs.azure_monitor]]
#   ## Timeout for HTTP writes.
#   # timeout = "20s"
#
#   ## Set the namespace prefix, defaults to "Telegraf/<input-name>".
#   # namespace_prefix = "Telegraf/"
#
#   ## Azure Monitor doesn't have a string value type, so convert string
#   ## fields to dimensions (a.k.a. tags) if enabled. Azure Monitor allows
#   ## a maximum of 10 dimensions so Telegraf will only send the first 10
#   ## alphanumeric dimensions.
#   # strings_as_dimensions = false
#
#   ## Both region and resource_id must be set or be available via the
#   ## Instance Metadata service on Azure Virtual Machines.
#   #
#   ## Azure Region to publish metrics against.
#   ##   ex: region = "southcentralus"
#   # region = ""
#   #
#   ## The Azure Resource ID against which metric will be logged, e.g.
#   ##   ex: resource_id = "/subscriptions/<subscription_id>/resourceGroups/<resource_group>/providers/Microsoft.Compute/virtualMachines/<vm_name>"
#   # resource_id = ""
#
#   ## Optionally, if in Azure US Government, China or other sovereign
#   ## cloud environment, set appropriate REST endpoint for receiving
#   ## metrics. (Note: region may be unused in this context)
#   # endpoint_url = "https://monitoring.core.usgovcloudapi.net"


# # Configuration for Google Cloud BigQuery to send entries
# [[outputs.bigquery]]
#   ## Credentials File
#   credentials_file = "/path/to/service/account/key.json"
#
#   ## Google Cloud Platform Project
#   project = "my-gcp-project"
#
#   ## The namespace for the metric descriptor
#   dataset = "telegraf"
#
#   ## Timeout for BigQuery operations.
#   # timeout = "5s"
#
#   ## Character to replace hyphens on Metric name
#   # replace_hyphen_to = "_"


# # Publish Telegraf metrics to a Google Cloud PubSub topic
# [[outputs.cloud_pubsub]]
#   ## Required. Name of Google Cloud Platform (GCP) Project that owns
#   ## the given PubSub topic.
#   project = "my-project"
#
#   ## Required. Name of PubSub topic to publish metrics to.
#   topic = "my-topic"
#
#   ## Required. Data format to consume.
#   ## Each data format has its own unique set of configuration options.
#   ## Read more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   data_format = "influx"
#
#   ## Optional. Filepath for GCP credentials JSON file to authorize calls to
#   ## PubSub APIs. If not set explicitly, Telegraf will attempt to use
#   ## Application Default Credentials, which is preferred.
#   # credentials_file = "path/to/my/creds.json"
#
#   ## Optional. If true, will send all metrics per write in one PubSub message.
#   # send_batched = true
#
#   ## The following publish_* parameters specifically configures batching
#   ## requests made to the GCP Cloud PubSub API via the PubSub Golang library. Read
#   ## more here: https://godoc.org/cloud.google.com/go/pubsub#PublishSettings
#
#   ## Optional. Send a request to PubSub (i.e. actually publish a batch)
#   ## when it has this many PubSub messages. If send_batched is true,
#   ## this is ignored and treated as if it were 1.
#   # publish_count_threshold = 1000
#
#   ## Optional. Send a request to PubSub (i.e. actually publish a batch)
#   ## when it has this many PubSub messages. If send_batched is true,
#   ## this is ignored and treated as if it were 1
#   # publish_byte_threshold = 1000000
#
#   ## Optional. Specifically configures requests made to the PubSub API.
#   # publish_num_go_routines = 2
#
#   ## Optional. Specifies a timeout for requests to the PubSub API.
#   # publish_timeout = "30s"
#
#   ## Optional. If true, published PubSub message data will be base64-encoded.
#   # base64_data = false
#
#   ## Optional. PubSub attributes to add to metrics.
#   # [outputs.cloud_pubsub.attributes]
#   #   my_attr = "tag_value"


# # Configuration for AWS CloudWatch output.
# [[outputs.cloudwatch]]
#   ## Amazon REGION
#   region = "us-east-1"
#
#   ## Amazon Credentials
#   ## Credentials are loaded in the following order
#   ## 1) Web identity provider credentials via STS if role_arn and web_identity_token_file are specified
#   ## 2) Assumed credentials via STS if role_arn is specified
#   ## 3) explicit credentials from 'access_key' and 'secret_key'
#   ## 4) shared profile from 'profile'
#   ## 5) environment variables
#   ## 6) shared credentials file
#   ## 7) EC2 Instance Profile
#   #access_key = ""
#   #secret_key = ""
#   #token = ""
#   #role_arn = ""
#   #web_identity_token_file = ""
#   #role_session_name = ""
#   #profile = ""
#   #shared_credential_file = ""
#
#   ## Endpoint to make request against, the correct endpoint is automatically
#   ## determined and this option should only be set if you wish to override the
#   ## default.
#   ##   ex: endpoint_url = "http://localhost:8000"
#   # endpoint_url = ""
#
#   ## Namespace for the CloudWatch MetricDatums
#   namespace = "InfluxData/Telegraf"
#
#   ## If you have a large amount of metrics, you should consider to send statistic
#   ## values instead of raw metrics which could not only improve performance but
#   ## also save AWS API cost. If enable this flag, this plugin would parse the required
#   ## CloudWatch statistic fields (count, min, max, and sum) and send them to CloudWatch.
#   ## You could use basicstats aggregator to calculate those fields. If not all statistic
#   ## fields are available, all fields would still be sent as raw metrics.
#   # write_statistics = false
#
#   ## Enable high resolution metrics of 1 second (if not enabled, standard resolution are of 60 seconds precision)
#   # high_resolution_metrics = false


# # Configuration for AWS CloudWatchLogs output.
# [[outputs.cloudwatch_logs]]
# ## The region is the Amazon region that you wish to connect to.
# ## Examples include but are not limited to:
# ## - us-west-1
# ## - us-west-2
# ## - us-east-1
# ## - ap-southeast-1
# ## - ap-southeast-2
# ## ...
# region = "us-east-1"
#
# ## Amazon Credentials
# ## Credentials are loaded in the following order
# ## 1) Web identity provider credentials via STS if role_arn and web_identity_token_file are specified
# ## 2) Assumed credentials via STS if role_arn is specified
# ## 3) explicit credentials from 'access_key' and 'secret_key'
# ## 4) shared profile from 'profile'
# ## 5) environment variables
# ## 6) shared credentials file
# ## 7) EC2 Instance Profile
# #access_key = ""
# #secret_key = ""
# #token = ""
# #role_arn = ""
# #web_identity_token_file = ""
# #role_session_name = ""
# #profile = ""
# #shared_credential_file = ""
#
# ## Endpoint to make request against, the correct endpoint is automatically
# ## determined and this option should only be set if you wish to override the
# ## default.
# ##   ex: endpoint_url = "http://localhost:8000"
# # endpoint_url = ""
#
# ## Cloud watch log group. Must be created in AWS cloudwatch logs upfront!
# ## For example, you can specify the name of the k8s cluster here to group logs from all cluster in oine place
# log_group = "my-group-name"
#
# ## Log stream in log group
# ## Either log group name or reference to metric attribute, from which it can be parsed:
# ## tag:<TAG_NAME> or field:<FIELD_NAME>. If log stream is not exist, it will be created.
# ## Since AWS is not automatically delete logs streams with expired logs entries (i.e. empty log stream)
# ## you need to put in place appropriate house-keeping (https://forums.aws.amazon.com/thread.jspa?threadID=178855)
# log_stream = "tag:location"
#
# ## Source of log data - metric name
# ## specify the name of the metric, from which the log data should be retrieved.
# ## I.e., if you  are using docker_log plugin to stream logs from container, then
# ## specify log_data_metric_name  = "docker_log"
# log_data_metric_name  = "docker_log"
#
# ## Specify from which metric attribute the log data should be retrieved:
# ## tag:<TAG_NAME> or field:<FIELD_NAME>.
# ## I.e., if you  are using docker_log plugin to stream logs from container, then
# ## specify log_data_source  = "field:message"
# log_data_source  = "field:message"


# # Configuration for CrateDB to send metrics to.
# [[outputs.cratedb]]
#   # A github.com/jackc/pgx/v4 connection string.
#   # See https://pkg.go.dev/github.com/jackc/pgx/v4#ParseConfig
#   url = "postgres://user:password@localhost/schema?sslmode=disable"
#   # Timeout for all CrateDB queries.
#   timeout = "5s"
#   # Name of the table to store metrics in.
#   table = "metrics"
#   # If true, and the metrics table does not exist, create it automatically.
#   table_create = true
#   # The character(s) to replace any '.' in an object key with
#   key_separator = "_"


# # Configuration for DataDog API to send metrics to.
# [[outputs.datadog]]
#   ## Datadog API key
#   apikey = "my-secret-key"
#
#   ## Connection timeout.
#   # timeout = "5s"
#
#   ## Write URL override; useful for debugging.
#   # url = "https://app.datadoghq.com/api/v1/series"
#
#   ## Set http_proxy (telegraf uses the system wide proxy settings if it isn't set)
#   # http_proxy_url = "http://localhost:8888"
#
#   ## Override the default (none) compression used to send data.
#   ## Supports: "zlib", "none"
#   # compression = "none"


# # Send metrics to nowhere at all
# [[outputs.discard]]
#   # no configuration


# # Send telegraf metrics to a Dynatrace environment
# [[outputs.dynatrace]]
#   ## For usage with the Dynatrace OneAgent you can omit any configuration,
#   ## the only requirement is that the OneAgent is running on the same host.
#   ## Only setup environment url and token if you want to monitor a Host without the OneAgent present.
#   ##
#   ## Your Dynatrace environment URL.
#   ## For Dynatrace OneAgent you can leave this empty or set it to "http://127.0.0.1:14499/metrics/ingest" (default)
#   ## For Dynatrace SaaS environments the URL scheme is "https://{your-environment-id}.live.dynatrace.com/api/v2/metrics/ingest"
#   ## For Dynatrace Managed environments the URL scheme is "https://{your-domain}/e/{your-environment-id}/api/v2/metrics/ingest"
#   url = ""
#
#   ## Your Dynatrace API token.
#   ## Create an API token within your Dynatrace environment, by navigating to Settings > Integration > Dynatrace API
#   ## The API token needs data ingest scope permission. When using OneAgent, no API token is required.
#   api_token = ""
#
#   ## Optional prefix for metric names (e.g.: "telegraf")
#   prefix = "telegraf"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#
#   ## Optional flag for ignoring tls certificate check
#   # insecure_skip_verify = false
#
#
#   ## Connection timeout, defaults to "5s" if not set.
#   timeout = "5s"
#
#   ## If you want metrics to be treated and reported as delta counters, add the metric names here
#   additional_counters = [ ]
#
#   ## Optional dimensions to be added to every metric
#   # [outputs.dynatrace.default_dimensions]
#   # default_key = "default value"


# # Configuration for Elasticsearch to send metrics to.
# [[outputs.elasticsearch]]
#   ## The full HTTP endpoint URL for your Elasticsearch instance
#   ## Multiple urls can be specified as part of the same cluster,
#   ## this means that only ONE of the urls will be written to each interval.
#   urls = [ "http://node1.es.example.com:9200" ] # required.
#   ## Elasticsearch client timeout, defaults to "5s" if not set.
#   timeout = "5s"
#   ## Set to true to ask Elasticsearch a list of all cluster nodes,
#   ## thus it is not necessary to list all nodes in the urls config option.
#   enable_sniffer = false
#   ## Set to true to enable gzip compression
#   enable_gzip = false
#   ## Set the interval to check if the Elasticsearch nodes are available
#   ## Setting to "0s" will disable the health check (not recommended in production)
#   health_check_interval = "10s"
#   ## HTTP basic authentication details
#   # username = "telegraf"
#   # password = "mypassword"
#   ## HTTP bearer token authentication details
#   # auth_bearer_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
#
#   ## Index Config
#   ## The target index for metrics (Elasticsearch will create if it not exists).
#   ## You can use the date specifiers below to create indexes per time frame.
#   ## The metric timestamp will be used to decide the destination index name
#   # %Y - year (2016)
#   # %y - last two digits of year (00..99)
#   # %m - month (01..12)
#   # %d - day of month (e.g., 01)
#   # %H - hour (00..23)
#   # %V - week of the year (ISO week) (01..53)
#   ## Additionally, you can specify a tag name using the notation {{tag_name}}
#   ## which will be used as part of the index name. If the tag does not exist,
#   ## the default tag value will be used.
#   # index_name = "telegraf-{{host}}-%Y.%m.%d"
#   # default_tag_value = "none"
#   index_name = "telegraf-%Y.%m.%d" # required.
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## Template Config
#   ## Set to true if you want telegraf to manage its index template.
#   ## If enabled it will create a recommended index template for telegraf indexes
#   manage_template = true
#   ## The template name used for telegraf indexes
#   template_name = "telegraf"
#   ## Set to true if you want telegraf to overwrite an existing template
#   overwrite_template = false
#   ## If set to true a unique ID hash will be sent as sha256(concat(timestamp,measurement,series-hash)) string
#   ## it will enable data resend and update metric points avoiding duplicated metrics with diferent id's
#   force_document_id = false
#
#   ## Specifies the handling of NaN and Inf values.
#   ## This option can have the following values:
#   ##    none    -- do not modify field-values (default); will produce an error if NaNs or infs are encountered
#   ##    drop    -- drop fields containing NaNs or infs
#   ##    replace -- replace with the value in "float_replacement_value" (default: 0.0)
#   ##               NaNs and inf will be replaced with the given number, -inf with the negative of that number
#   # float_handling = "none"
#   # float_replacement_value = 0.0
#
#   ## Pipeline Config
#   ## To use a ingest pipeline, set this to the name of the pipeline you want to use.
#   # use_pipeline = "my_pipeline"
#   ## Additionally, you can specify a tag name using the notation {{tag_name}}
#   ## which will be used as part of the pipeline name. If the tag does not exist,
#   ## the default pipeline will be used as the pipeline. If no default pipeline is set,
#   ## no pipeline is used for the metric.
#   # use_pipeline = "{{es_pipeline}}"
#   # default_pipeline = "my_pipeline"


# # Configuration for Event Hubs output plugin
# [[outputs.event_hubs]]
#   ## The full connection string to the Event Hub (required)
#   ## The shared access key must have "Send" permissions on the target Event Hub.
#   connection_string = "Endpoint=sb://namespace.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=superSecret1234=;EntityPath=hubName"
#
#   ## Client timeout (defaults to 30s)
#   # timeout = "30s"
#
#   ## Data format to output.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_OUTPUT.md
#   data_format = "json"


# # Send metrics to command as input over stdin
# [[outputs.exec]]
#   ## Command to ingest metrics via stdin.
#   command = ["tee", "-a", "/dev/null"]
#
#   ## Timeout for command to complete.
#   # timeout = "5s"
#
#   ## Data format to output.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_OUTPUT.md
#   # data_format = "influx"


# # Run executable as long-running output plugin
# [[outputs.execd]]
#   ## Program to run as daemon
#   command = ["my-telegraf-output", "--some-flag", "value"]
#
#   ## Delay before the process is restarted after an unexpected termination
#   restart_delay = "10s"
#
#   ## Data format to export.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_OUTPUT.md
#   data_format = "influx"


# # Send telegraf metrics to file(s)
# [[outputs.file]]
#   ## Files to write to, "stdout" is a specially handled file.
#   files = ["stdout", "/tmp/metrics.out"]
#
#   ## Use batch serialization format instead of line based delimiting.  The
#   ## batch format allows for the production of non line based output formats and
#   ## may more efficiently encode metric groups.
#   # use_batch_format = false
#
#   ## The file will be rotated after the time interval specified.  When set
#   ## to 0 no time based rotation is performed.
#   # rotation_interval = "0d"
#
#   ## The logfile will be rotated when it becomes larger than the specified
#   ## size.  When set to 0 no size based rotation is performed.
#   # rotation_max_size = "0MB"
#
#   ## Maximum number of rotated archives to keep, any older logs are deleted.
#   ## If set to -1, no archives are removed.
#   # rotation_max_archives = 5
#
#   ## Data format to output.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_OUTPUT.md
#   data_format = "influx"


# # Configuration for Graphite server to send metrics to
# [[outputs.graphite]]
#   ## TCP endpoint for your graphite instance.
#   ## If multiple endpoints are configured, output will be load balanced.
#   ## Only one of the endpoints will be written to with each iteration.
#   servers = ["localhost:2003"]
#   ## Prefix metrics name
#   prefix = ""
#   ## Graphite output template
#   ## see https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_OUTPUT.md
#   template = "host.tags.measurement.field"
#
#   ## Enable Graphite tags support
#   # graphite_tag_support = false
#
#   ## Define how metric names and tags are sanitized; options are "strict", or "compatible"
#   ## strict - Default method, and backwards compatible with previous versionf of Telegraf
#   ## compatible - More relaxed sanitizing when using tags, and compatible with the graphite spec
#   # graphite_tag_sanitize_mode = "strict"
#
#   ## Character for separating metric name and field for Graphite tags
#   # graphite_separator = "."
#
#   ## Graphite templates patterns
#   ## 1. Template for cpu
#   ## 2. Template for disk*
#   ## 3. Default template
#   # templates = [
#   #  "cpu tags.measurement.host.field",
#   #  "disk* measurement.field",
#   #  "host.measurement.tags.field"
#   #]
#
#   ## timeout in seconds for the write connection to graphite
#   timeout = 2
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Send telegraf metrics to graylog
# [[outputs.graylog]]
#   ## Endpoints for your graylog instances.
#   servers = ["udp://127.0.0.1:12201"]
#
#   ## Connection timeout.
#   # timeout = "5s"
#
#   ## The field to use as the GELF short_message, if unset the static string
#   ## "telegraf" will be used.
#   ##   example: short_message_field = "message"
#   # short_message_field = ""
#
#   ## According to GELF payload specification, additional fields names must be prefixed
#   ## with an underscore. Previous versions did not prefix custom field 'name' with underscore.
#   ## Set to true for backward compatibility.
#   # name_field_no_prefix = false
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Send telegraf metrics to GroundWork Monitor
# [[outputs.groundwork]]
#   ## URL of your groundwork instance.
#   url = "https://groundwork.example.com"
#
#   ## Agent uuid for GroundWork API Server.
#   agent_id = ""
#
#   ## Username and password to access GroundWork API.
#   username = ""
#   password = ""
#
#   ## Default display name for the host with services(metrics).
#   # default_host = "telegraf"
#
#   ## Default service state.
#   # default_service_state = "SERVICE_OK"
#
#   ## The name of the tag that contains the hostname.
#   # resource_tag = "host"
#
#   ## The name of the tag that contains the host group name.
#   # group_tag = "group"


# # Configurable HTTP health check resource based on metrics
# [[outputs.health]]
#   ## Address and port to listen on.
#   ##   ex: service_address = "http://localhost:8080"
#   ##       service_address = "unix:///var/run/telegraf-health.sock"
#   # service_address = "http://:8080"
#
#   ## The maximum duration for reading the entire request.
#   # read_timeout = "5s"
#   ## The maximum duration for writing the entire response.
#   # write_timeout = "5s"
#
#   ## Username and password to accept for HTTP basic authentication.
#   # basic_username = "user1"
#   # basic_password = "secret"
#
#   ## Allowed CA certificates for client certificates.
#   # tls_allowed_cacerts = ["/etc/telegraf/clientca.pem"]
#
#   ## TLS server certificate and private key.
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#
#   ## One or more check sub-tables should be defined, it is also recommended to
#   ## use metric filtering to limit the metrics that flow into this output.
#   ##
#   ## When using the default buffer sizes, this example will fail when the
#   ## metric buffer is half full.
#   ##
#   ## namepass = ["internal_write"]
#   ## tagpass = { output = ["influxdb"] }
#   ##
#   ## [[outputs.health.compares]]
#   ##   field = "buffer_size"
#   ##   lt = 5000.0
#   ##
#   ## [[outputs.health.contains]]
#   ##   field = "buffer_size"


# # A plugin that can transmit metrics over HTTP
# [[outputs.http]]
#   ## URL is the address to send metrics to
#   url = "http://127.0.0.1:8080/telegraf"
#
#   ## Timeout for HTTP message
#   # timeout = "5s"
#
#   ## HTTP method, one of: "POST" or "PUT"
#   # method = "POST"
#
#   ## HTTP Basic Auth credentials
#   # username = "username"
#   # password = "pa$$word"
#
#   ## OAuth2 Client Credentials Grant
#   # client_id = "clientid"
#   # client_secret = "secret"
#   # token_url = "https://indentityprovider/oauth2/v1/token"
#   # scopes = ["urn:opc:idm:__myscopes__"]
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## Optional Cookie authentication
#   # cookie_auth_url = "https://localhost/authMe"
#   # cookie_auth_method = "POST"
#   # cookie_auth_username = "username"
#   # cookie_auth_password = "pa$$word"
#   # cookie_auth_headers = '{"Content-Type": "application/json", "X-MY-HEADER":"hello"}'
#   # cookie_auth_body = '{"username": "user", "password": "pa$$word", "authenticate": "me"}'
#   ## cookie_auth_renewal not set or set to "0" will auth once and never renew the cookie
#   # cookie_auth_renewal = "5m"
#
#   ## Data format to output.
#   ## Each data format has it's own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_OUTPUT.md
#   # data_format = "influx"
#
#   ## Use batch serialization format (default) instead of line based format.
#   ## Batch format is more efficient and should be used unless line based
#   ## format is really needed.
#   # use_batch_format = true
#
#   ## HTTP Content-Encoding for write request body, can be set to "gzip" to
#   ## compress body or "identity" to apply no encoding.
#   # content_encoding = "identity"
#
#   ## Additional HTTP headers
#   # [outputs.http.headers]
#   #   # Should be set manually to "application/json" for json data_format
#   #   Content-Type = "text/plain; charset=utf-8"
#
#   ## Idle (keep-alive) connection timeout.
#   ## Maximum amount of time before idle connection is closed.
#   ## Zero means no limit.
#   # idle_conn_timeout = 0
#
#   ## Amazon Region
#   #region = "us-east-1"
#
#   ## Amazon Credentials
#   ## Credentials are loaded in the following order
#   ## 1) Web identity provider credentials via STS if role_arn and web_identity_token_file are specified
#   ## 2) Assumed credentials via STS if role_arn is specified
#   ## 3) explicit credentials from 'access_key' and 'secret_key'
#   ## 4) shared profile from 'profile'
#   ## 5) environment variables
#   ## 6) shared credentials file
#   ## 7) EC2 Instance Profile
#   #access_key = ""
#   #secret_key = ""
#   #token = ""
#   #role_arn = ""
#   #web_identity_token_file = ""
#   #role_session_name = ""
#   #profile = ""
#   #shared_credential_file = ""


# # Configuration for sending metrics to InfluxDB
[[outputs.influxdb_v2]]
  ## The URLs of the InfluxDB cluster nodes.
  ##
  ## Multiple URLs can be specified for a single cluster, only ONE of the
  ## urls will be written to each interval.
  ##   ex: urls = ["https://us-west-2-1.aws.cloud2.influxdata.com"]
  #urls = ["http://${DOCKER_INFLUXDB_HOSTNAME}:${DOCKER_INFLUXDB_INIT_PORT}"]

  ## Token for authentication.
  token = "${DOCKER_INFLUXDB_INIT_ADMIN_TOKEN}"

  ## Organization is the name of the organization you wish to write to; must exist.
  organization = "${DOCKER_INFLUXDB_INIT_ORG}"

  ## Destination bucket to write into.
  bucket = "${DOCKER_INFLUXDB_INIT_BUCKET}"

#   ## The value of this tag will be used to determine the bucket.  If this
#   ## tag is not set the 'bucket' option is used as the default.
#   # bucket_tag = ""
#
#   ## If true, the bucket tag will not be added to the metric.
#   # exclude_bucket_tag = false
#
#   ## Timeout for HTTP messages.
#   # timeout = "5s"
#
#   ## Additional HTTP headers
#   # http_headers = {"X-Special-Header" = "Special-Value"}
#
#   ## HTTP Proxy override, if unset values the standard proxy environment
#   ## variables are consulted to determine which proxy, if any, should be used.
#   # http_proxy = "http://corporate.proxy:3128"
#
#   ## HTTP User-Agent
#   # user_agent = "telegraf"
#
#   ## Content-Encoding for write request body, can be set to "gzip" to
#   ## compress body or "identity" to apply no encoding.
#   # content_encoding = "gzip"
#
#   ## Enable or disable uint support for writing uints influxdb 2.0.
#   # influx_uint_support = false
#
#   ## Optional TLS Config for use on HTTP connections.
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
  ## Use TLS but skip chain & host verification
  insecure_skip_verify = false


# # Configuration for sending metrics to an Instrumental project
# [[outputs.instrumental]]
#   ## Project API Token (required)
#   api_token = "API Token" # required
#   ## Prefix the metrics with a given name
#   prefix = ""
#   ## Stats output template (Graphite formatting)
#   ## see https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_OUTPUT.md#graphite
#   template = "host.tags.measurement.field"
#   ## Timeout in seconds to connect
#   timeout = "2s"
#   ## Display Communication to Instrumental
#   debug = false


# # Configuration for the Kafka server to send metrics to
# [[outputs.kafka]]
#   ## URLs of kafka brokers
#   brokers = ["localhost:9092"]
#   ## Kafka topic for producer messages
#   topic = "telegraf"
#
#   ## The value of this tag will be used as the topic.  If not set the 'topic'
#   ## option is used.
#   # topic_tag = ""
#
#   ## If true, the 'topic_tag' will be removed from to the metric.
#   # exclude_topic_tag = false
#
#   ## Optional Client id
#   # client_id = "Telegraf"
#
#   ## Set the minimal supported Kafka version.  Setting this enables the use of new
#   ## Kafka features and APIs.  Of particular interest, lz4 compression
#   ## requires at least version 0.10.0.0.
#   ##   ex: version = "1.1.0"
#   # version = ""
#
#   ## Optional topic suffix configuration.
#   ## If the section is omitted, no suffix is used.
#   ## Following topic suffix methods are supported:
#   ##   measurement - suffix equals to separator + measurement's name
#   ##   tags        - suffix equals to separator + specified tags' values
#   ##                 interleaved with separator
#
#   ## Suffix equals to "_" + measurement name
#   # [outputs.kafka.topic_suffix]
#   #   method = "measurement"
#   #   separator = "_"
#
#   ## Suffix equals to "__" + measurement's "foo" tag value.
#   ##   If there's no such a tag, suffix equals to an empty string
#   # [outputs.kafka.topic_suffix]
#   #   method = "tags"
#   #   keys = ["foo"]
#   #   separator = "__"
#
#   ## Suffix equals to "_" + measurement's "foo" and "bar"
#   ##   tag values, separated by "_". If there is no such tags,
#   ##   their values treated as empty strings.
#   # [outputs.kafka.topic_suffix]
#   #   method = "tags"
#   #   keys = ["foo", "bar"]
#   #   separator = "_"
#
#   ## The routing tag specifies a tagkey on the metric whose value is used as
#   ## the message key.  The message key is used to determine which partition to
#   ## send the message to.  This tag is prefered over the routing_key option.
#   routing_tag = "host"
#
#   ## The routing key is set as the message key and used to determine which
#   ## partition to send the message to.  This value is only used when no
#   ## routing_tag is set or as a fallback when the tag specified in routing tag
#   ## is not found.
#   ##
#   ## If set to "random", a random value will be generated for each message.
#   ##
#   ## When unset, no message key is added and each message is routed to a random
#   ## partition.
#   ##
#   ##   ex: routing_key = "random"
#   ##       routing_key = "telegraf"
#   # routing_key = ""
#
#   ## Compression codec represents the various compression codecs recognized by
#   ## Kafka in messages.
#   ##  0 : None
#   ##  1 : Gzip
#   ##  2 : Snappy
#   ##  3 : LZ4
#   ##  4 : ZSTD
#   # compression_codec = 0
#
#   ## Idempotent Writes
#   ## If enabled, exactly one copy of each message is written.
#   # idempotent_writes = false
#
#   ##  RequiredAcks is used in Produce Requests to tell the broker how many
#   ##  replica acknowledgements it must see before responding
#   ##   0 : the producer never waits for an acknowledgement from the broker.
#   ##       This option provides the lowest latency but the weakest durability
#   ##       guarantees (some data will be lost when a server fails).
#   ##   1 : the producer gets an acknowledgement after the leader replica has
#   ##       received the data. This option provides better durability as the
#   ##       client waits until the server acknowledges the request as successful
#   ##       (only messages that were written to the now-dead leader but not yet
#   ##       replicated will be lost).
#   ##   -1: the producer gets an acknowledgement after all in-sync replicas have
#   ##       received the data. This option provides the best durability, we
#   ##       guarantee that no messages will be lost as long as at least one in
#   ##       sync replica remains.
#   # required_acks = -1
#
#   ## The maximum number of times to retry sending a metric before failing
#   ## until the next flush.
#   # max_retry = 3
#
#   ## The maximum permitted size of a message. Should be set equal to or
#   ## smaller than the broker's 'message.max.bytes'.
#   # max_message_bytes = 1000000
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## Optional SOCKS5 proxy to use when connecting to brokers
#   # socks5_enabled = true
#   # socks5_address = "127.0.0.1:1080"
#   # socks5_username = "alice"
#   # socks5_password = "pass123"
#
#   ## Optional SASL Config
#   # sasl_username = "kafka"
#   # sasl_password = "secret"
#
#   ## Optional SASL:
#   ## one of: OAUTHBEARER, PLAIN, SCRAM-SHA-256, SCRAM-SHA-512, GSSAPI
#   ## (defaults to PLAIN)
#   # sasl_mechanism = ""
#
#   ## used if sasl_mechanism is GSSAPI (experimental)
#   # sasl_gssapi_service_name = ""
#   # ## One of: KRB5_USER_AUTH and KRB5_KEYTAB_AUTH
#   # sasl_gssapi_auth_type = "KRB5_USER_AUTH"
#   # sasl_gssapi_kerberos_config_path = "/"
#   # sasl_gssapi_realm = "realm"
#   # sasl_gssapi_key_tab_path = ""
#   # sasl_gssapi_disable_pafxfast = false
#
#   ## used if sasl_mechanism is OAUTHBEARER (experimental)
#   # sasl_access_token = ""
#
#   ## SASL protocol version.  When connecting to Azure EventHub set to 0.
#   # sasl_version = 1
#
#   # Disable Kafka metadata full fetch
#   # metadata_full = false
#
#   ## Data format to output.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_OUTPUT.md
#   # data_format = "influx"


# # Configuration for the AWS Kinesis output.
# [[outputs.kinesis]]
#   ## Amazon REGION of kinesis endpoint.
#   region = "ap-southeast-2"
#
#   ## Amazon Credentials
#   ## Credentials are loaded in the following order
#   ## 1) Web identity provider credentials via STS if role_arn and web_identity_token_file are specified
#   ## 2) Assumed credentials via STS if role_arn is specified
#   ## 3) explicit credentials from 'access_key' and 'secret_key'
#   ## 4) shared profile from 'profile'
#   ## 5) environment variables
#   ## 6) shared credentials file
#   ## 7) EC2 Instance Profile
#   #access_key = ""
#   #secret_key = ""
#   #token = ""
#   #role_arn = ""
#   #web_identity_token_file = ""
#   #role_session_name = ""
#   #profile = ""
#   #shared_credential_file = ""
#
#   ## Endpoint to make request against, the correct endpoint is automatically
#   ## determined and this option should only be set if you wish to override the
#   ## default.
#   ##   ex: endpoint_url = "http://localhost:8000"
#   # endpoint_url = ""
#
#   ## Kinesis StreamName must exist prior to starting telegraf.
#   streamname = "StreamName"
#
#   ## The partition key can be calculated using one of several methods:
#   ##
#   ## Use a static value for all writes:
#   #  [outputs.kinesis.partition]
#   #    method = "static"
#   #    key = "howdy"
#   #
#   ## Use a random partition key on each write:
#   #  [outputs.kinesis.partition]
#   #    method = "random"
#   #
#   ## Use the measurement name as the partition key:
#   #  [outputs.kinesis.partition]
#   #    method = "measurement"
#   #
#   ## Use the value of a tag for all writes, if the tag is not set the empty
#   ## default option will be used. When no default, defaults to "telegraf"
#   #  [outputs.kinesis.partition]
#   #    method = "tag"
#   #    key = "host"
#   #    default = "mykey"
#
#
#   ## Data format to output.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_OUTPUT.md
#   data_format = "influx"
#
#   ## debug will show upstream aws messages.
#   debug = false


# # Configuration for Librato API to send metrics to.
# [[outputs.librato]]
#   ## Librato API Docs
#   ## http://dev.librato.com/v1/metrics-authentication
#   ## Librato API user
#   api_user = "telegraf@influxdb.com" # required.
#   ## Librato API token
#   api_token = "my-secret-token" # required.
#   ## Debug
#   # debug = false
#   ## Connection timeout.
#   # timeout = "5s"
#   ## Output source Template (same as graphite buckets)
#   ## see https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_OUTPUT.md#graphite
#   ## This template is used in librato's source (not metric's name)
#   template = "host"
#


# # Send aggregate metrics to Logz.io
# [[outputs.logzio]]
#   ## Connection timeout, defaults to "5s" if not set.
#   timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#
#   ## Logz.io account token
#   token = "your logz.io token" # required
#
#   ## Use your listener URL for your Logz.io account region.
#   # url = "https://listener.logz.io:8071"


# # Send logs to Loki
# [[outputs.loki]]
#   ## The domain of Loki
#   domain = "https://loki.domain.tld"
#
#   ## Endpoint to write api
#   # endpoint = "/loki/api/v1/push"
#
#   ## Connection timeout, defaults to "5s" if not set.
#   # timeout = "5s"
#
#   ## Basic auth credential
#   # username = "loki"
#   # password = "pass"
#
#   ## Additional HTTP headers
#   # http_headers = {"X-Scope-OrgID" = "1"}
#
#   ## If the request must be gzip encoded
#   # gzip_request = false
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"


# # Sends metrics to MongoDB
# [[outputs.mongodb]]
#   # connection string examples for mongodb
#   dsn = "mongodb://localhost:27017"
#   # dsn = "mongodb://mongod1:27017,mongod2:27017,mongod3:27017/admin&replicaSet=myReplSet&w=1"
#
#   # overrides serverSelectionTimeoutMS in dsn if set
#   # timeout = "30s"
#
#   # default authentication, optional
#   # authentication = "NONE"
#
#   # for SCRAM-SHA-256 authentication
#   # authentication = "SCRAM"
#   # username = "root"
#   # password = "***"
#
#   # for x509 certificate authentication
#   # authentication = "X509"
#   # tls_ca = "ca.pem"
#   # tls_key = "client.pem"
#   # # tls_key_pwd = "changeme" # required for encrypted tls_key
#   # insecure_skip_verify = false
#
#   # database to store measurements and time series collections
#   # database = "telegraf"
#
#   # granularity can be seconds, minutes, or hours.
#   # configuring this value will be based on your input collection frequency.
#   # see https://docs.mongodb.com/manual/core/timeseries-collections/#create-a-time-series-collection
#   # granularity = "seconds"
#
#   # optionally set a TTL to automatically expire documents from the measurement collections.
#   # ttl = "360h"


# # Configuration for MQTT server to send metrics to
# [[outputs.mqtt]]
#   ## MQTT Brokers
#   ## The list of brokers should only include the hostname or IP address and the
#   ## port to the broker. This should follow the format '{host}:{port}'. For
#   ## example, "localhost:1883" or "127.0.0.1:8883".
#   servers = ["localhost:1883"]
#
#   ## MQTT Topic for Producer Messages
#   ## MQTT outputs send metrics to this topic format:
#   ## <topic_prefix>/<hostname>/<pluginname>/ (e.g. prefix/web01.example.com/mem)
#   topic_prefix = "telegraf"
#
#   ## QoS policy for messages
#   ## The mqtt QoS policy for sending messages.
#   ## See https://www.ibm.com/support/knowledgecenter/en/SSFKSJ_9.0.0/com.ibm.mq.dev.doc/q029090_.htm
#   ##   0 = at most once
#   ##   1 = at least once
#   ##   2 = exactly once
#   # qos = 2
#
#   ## Keep Alive
#   ## Defines the maximum length of time that the broker and client may not
#   ## communicate. Defaults to 0 which turns the feature off.
#   ##
#   ## For version v2.0.12 and later mosquitto there is a bug
#   ## (see https://github.com/eclipse/mosquitto/issues/2117), which requires
#   ## this to be non-zero. As a reference eclipse/paho.mqtt.golang defaults to 30.
#   # keep_alive = 0
#
#   ## username and password to connect MQTT server.
#   # username = "telegraf"
#   # password = "metricsmetricsmetricsmetrics"
#
#   ## client ID
#   ## The unique client id to connect MQTT server. If this parameter is not set
#   ## then a random ID is generated.
#   # client_id = ""
#
#   ## Timeout for write operations. default: 5s
#   # timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## When true, metrics will be sent in one MQTT message per flush. Otherwise,
#   ## metrics are written one metric per MQTT message.
#   # batch = false
#
#   ## When true, metric will have RETAIN flag set, making broker cache entries until someone
#   ## actually reads it
#   # retain = false
#
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_OUTPUT.md
#   data_format = "influx"


# # Send telegraf measurements to NATS
# [[outputs.nats]]
#   ## URLs of NATS servers
#   servers = ["nats://localhost:4222"]
#
#   ## Optional client name
#   # name = ""
#
#   ## Optional credentials
#   # username = ""
#   # password = ""
#
#   ## Optional NATS 2.0 and NATS NGS compatible user credentials
#   # credentials = "/etc/telegraf/nats.creds"
#
#   ## NATS subject for producer messages
#   subject = "telegraf"
#
#   ## Use Transport Layer Security
#   # secure = false
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## Data format to output.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_OUTPUT.md
#   data_format = "influx"


# # Send metrics to New Relic metrics endpoint
# [[outputs.newrelic]]
#   ## The 'insights_key' parameter requires a NR license key.
#   ## New Relic recommends you create one
#   ## with a convenient name such as TELEGRAF_INSERT_KEY.
#   ## reference: https://docs.newrelic.com/docs/apis/intro-apis/new-relic-api-keys/#ingest-license-key
#   # insights_key = "New Relic License Key Here"
#
#   ## Prefix to add to add to metric name for easy identification.
#   ## This is very useful if your metric names are ambiguous.
#   # metric_prefix = ""
#
#   ## Timeout for writes to the New Relic API.
#   # timeout = "15s"
#
#   ## HTTP Proxy override. If unset use values from the standard
#   ## proxy environment variables to determine proxy, if any.
#   # http_proxy = "http://corporate.proxy:3128"
#
#   ## Metric URL override to enable geographic location endpoints.
#   # If not set use values from the standard
#   # metric_url = "https://metric-api.newrelic.com/metric/v1"


# # Send telegraf measurements to NSQD
# [[outputs.nsq]]
#   ## Location of nsqd instance listening on TCP
#   server = "localhost:4150"
#   ## NSQ topic for producer messages
#   topic = "telegraf"
#
#   ## Data format to output.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_OUTPUT.md
#   data_format = "influx"


# # Send OpenTelemetry metrics over gRPC
# [[outputs.opentelemetry]]
#   ## Override the default (localhost:4317) OpenTelemetry gRPC service
#   ## address:port
#   # service_address = "localhost:4317"
#
#   ## Override the default (5s) request timeout
#   # timeout = "5s"
#
#   ## Optional TLS Config.
#   ##
#   ## Root certificates for verifying server certificates encoded in PEM format.
#   # tls_ca = "/etc/telegraf/ca.pem"
#   ## The public and private keypairs for the client encoded in PEM format.
#   ## May contain intermediate certificates.
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS, but skip TLS chain and host verification.
#   # insecure_skip_verify = false
#   ## Send the specified TLS server name via SNI.
#   # tls_server_name = "foo.example.com"
#
#   ## Override the default (gzip) compression used to send data.
#   ## Supports: "gzip", "none"
#   # compression = "gzip"
#
#   ## Additional OpenTelemetry resource attributes
#   # [outputs.opentelemetry.attributes]
#   # "service.name" = "demo"
#
#   ## Additional gRPC request metadata
#   # [outputs.opentelemetry.headers]
#   # key1 = "value1"


# # Configuration for OpenTSDB server to send metrics to
# [[outputs.opentsdb]]
#   ## prefix for metrics keys
#   prefix = "my.specific.prefix."
#
#   ## DNS name of the OpenTSDB server
#   ## Using "opentsdb.example.com" or "tcp://opentsdb.example.com" will use the
#   ## telnet API. "http://opentsdb.example.com" will use the Http API.
#   host = "opentsdb.example.com"
#
#   ## Port of the OpenTSDB server
#   port = 4242
#
#   ## Number of data points to send to OpenTSDB in Http requests.
#   ## Not used with telnet API.
#   http_batch_size = 50
#
#   ## URI Path for Http requests to OpenTSDB.
#   ## Used in cases where OpenTSDB is located behind a reverse proxy.
#   http_path = "/api/put"
#
#   ## Debug true - Prints OpenTSDB communication
#   debug = false
#
#   ## Separator separates measurement name from field
#   separator = "_"


# # Configuration for the Prometheus client to spawn
# [[outputs.prometheus_client]]
#   ## Address to listen on
#   listen = ":9273"
#
#   ## Metric version controls the mapping from Telegraf metrics into
#   ## Prometheus format.  When using the prometheus input, use the same value in
#   ## both plugins to ensure metrics are round-tripped without modification.
#   ##
#   ##   example: metric_version = 1;
#   ##            metric_version = 2; recommended version
#   # metric_version = 1
#
#   ## Use HTTP Basic Authentication.
#   # basic_username = "Foo"
#   # basic_password = "Bar"
#
#   ## If set, the IP Ranges which are allowed to access metrics.
#   ##   ex: ip_range = ["192.168.0.0/24", "192.168.1.0/30"]
#   # ip_range = []
#
#   ## Path to publish the metrics on.
#   # path = "/metrics"
#
#   ## Expiration interval for each metric. 0 == no expiration
#   # expiration_interval = "60s"
#
#   ## Collectors to enable, valid entries are "gocollector" and "process".
#   ## If unset, both are enabled.
#   # collectors_exclude = ["gocollector", "process"]
#
#   ## Send string metrics as Prometheus labels.
#   ## Unless set to false all string metrics will be sent as labels.
#   # string_as_label = true
#
#   ## If set, enable TLS with the given certificate.
#   # tls_cert = "/etc/ssl/telegraf.crt"
#   # tls_key = "/etc/ssl/telegraf.key"
#
#   ## Set one or more allowed client CA certificate file names to
#   ## enable mutually authenticated TLS connections
#   # tls_allowed_cacerts = ["/etc/telegraf/clientca.pem"]
#
#   ## Export metric collection time.
#   # export_timestamp = false


# # Configuration for the Riemann server to send metrics to
# [[outputs.riemann]]
#   ## The full TCP or UDP URL of the Riemann server
#   url = "tcp://localhost:5555"
#
#   ## Riemann event TTL, floating-point time in seconds.
#   ## Defines how long that an event is considered valid for in Riemann
#   # ttl = 30.0
#
#   ## Separator to use between measurement and field name in Riemann service name
#   ## This does not have any effect if 'measurement_as_attribute' is set to 'true'
#   separator = "/"
#
#   ## Set measurement name as Riemann attribute 'measurement', instead of prepending it to the Riemann service name
#   # measurement_as_attribute = false
#
#   ## Send string metrics as Riemann event states.
#   ## Unless enabled all string metrics will be ignored
#   # string_as_state = false
#
#   ## A list of tag keys whose values get sent as Riemann tags.
#   ## If empty, all Telegraf tag values will be sent as tags
#   # tag_keys = ["telegraf","custom_tag"]
#
#   ## Additional Riemann tags to send.
#   # tags = ["telegraf-output"]
#
#   ## Description for Riemann event
#   # description_text = "metrics collected from telegraf"
#
#   ## Riemann client write timeout, defaults to "5s" if not set.
#   # timeout = "5s"


# # Configuration for the Riemann server to send metrics to
# [[outputs.riemann_legacy]]
#   ## DEPRECATED: The 'riemann_legacy' plugin is deprecated in version 1.3.0, use 'outputs.riemann' instead (see https://github.com/influxdata/telegraf/issues/1878).
#   ## URL of server
#   url = "localhost:5555"
#   ## transport protocol to use either tcp or udp
#   transport = "tcp"
#   ## separator to use between input name and field name in Riemann service name
#   separator = " "


# # Send aggregate metrics to Sensu Monitor
# [[outputs.sensu]]
#   ## BACKEND API URL is the Sensu Backend API root URL to send metrics to
#   ## (protocol, host, and port only). The output plugin will automatically
#   ## append the corresponding backend API path
#   ## /api/core/v2/namespaces/:entity_namespace/events/:entity_name/:check_name).
#   ##
#   ## Backend Events API reference:
#   ## https://docs.sensu.io/sensu-go/latest/api/events/
#   ##
#   ## AGENT API URL is the Sensu Agent API root URL to send metrics to
#   ## (protocol, host, and port only). The output plugin will automatically
#   ## append the correspeonding agent API path (/events).
#   ##
#   ## Agent API Events API reference:
#   ## https://docs.sensu.io/sensu-go/latest/api/events/
#   ##
#   ## NOTE: if backend_api_url and agent_api_url and api_key are set, the output
#   ## plugin will use backend_api_url. If backend_api_url and agent_api_url are
#   ## not provided, the output plugin will default to use an agent_api_url of
#   ## http://127.0.0.1:3031
#   ##
#   # backend_api_url = "http://127.0.0.1:8080"
#   # agent_api_url = "http://127.0.0.1:3031"
#
#   ## API KEY is the Sensu Backend API token
#   ## Generate a new API token via:
#   ##
#   ## $ sensuctl cluster-role create telegraf --verb create --resource events,entities
#   ## $ sensuctl cluster-role-binding create telegraf --cluster-role telegraf --group telegraf
#   ## $ sensuctl user create telegraf --group telegraf --password REDACTED
#   ## $ sensuctl api-key grant telegraf
#   ##
#   ## For more information on Sensu RBAC profiles & API tokens, please visit:
#   ## - https://docs.sensu.io/sensu-go/latest/reference/rbac/
#   ## - https://docs.sensu.io/sensu-go/latest/reference/apikeys/
#   ##
#   # api_key = "${SENSU_API_KEY}"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## Timeout for HTTP message
#   # timeout = "5s"
#
#   ## HTTP Content-Encoding for write request body, can be set to "gzip" to
#   ## compress body or "identity" to apply no encoding.
#   # content_encoding = "identity"
#
#   ## Sensu Event details
#   ##
#   ## Below are the event details to be sent to Sensu.  The main portions of the
#   ## event are the check, entity, and metrics specifications. For more information
#   ## on Sensu events and its components, please visit:
#   ## - Events - https://docs.sensu.io/sensu-go/latest/reference/events
#   ## - Checks -  https://docs.sensu.io/sensu-go/latest/reference/checks
#   ## - Entities - https://docs.sensu.io/sensu-go/latest/reference/entities
#   ## - Metrics - https://docs.sensu.io/sensu-go/latest/reference/events#metrics
#   ##
#   ## Check specification
#   ## The check name is the name to give the Sensu check associated with the event
#   ## created. This maps to check.metatadata.name in the event.
#   [outputs.sensu.check]
#   name = "telegraf"
#
#   ## Entity specification
#   ## Configure the entity name and namespace, if necessary. This will be part of
#   ## the entity.metadata in the event.
#   ##
#   ## NOTE: if the output plugin is configured to send events to a
#   ## backend_api_url and entity_name is not set, the value returned by
#   ## os.Hostname() will be used; if the output plugin is configured to send
#   ## events to an agent_api_url, entity_name and entity_namespace are not used.
#   # [outputs.sensu.entity]
#   #   name = "server-01"
#   #   namespace = "default"
#
#   ## Metrics specification
#   ## Configure the tags for the metrics that are sent as part of the Sensu event
#   # [outputs.sensu.tags]
#   #   source = "telegraf"
#
#   ## Configure the handler(s) for processing the provided metrics
#   # [outputs.sensu.metrics]
#   #   handlers = ["influxdb","elasticsearch"]


# # Send metrics and events to SignalFx
# [[outputs.signalfx]]
#     ## SignalFx Org Access Token
#     access_token = "my-secret-token"
#
#     ## The SignalFx realm that your organization resides in
#     signalfx_realm = "us9"  # Required if ingest_url is not set
#
#     ## You can optionally provide a custom ingest url instead of the
#     ## signalfx_realm option above if you are using a gateway or proxy
#     ## instance.  This option takes precident over signalfx_realm.
#     ingest_url = "https://my-custom-ingest/"
#
#     ## Event typed metrics are omitted by default,
#     ## If you require an event typed metric you must specify the
#     ## metric name in the following list.
#     included_event_names = ["plugin.metric_name"]


# # Generic socket writer capable of handling multiple socket types.
# [[outputs.socket_writer]]
#   ## URL to connect to
#   # address = "tcp://127.0.0.1:8094"
#   # address = "tcp://example.com:http"
#   # address = "tcp4://127.0.0.1:8094"
#   # address = "tcp6://127.0.0.1:8094"
#   # address = "tcp6://[2001:db8::1]:8094"
#   # address = "udp://127.0.0.1:8094"
#   # address = "udp4://127.0.0.1:8094"
#   # address = "udp6://127.0.0.1:8094"
#   # address = "unix:///tmp/telegraf.sock"
#   # address = "unixgram:///tmp/telegraf.sock"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## Period between keep alive probes.
#   ## Only applies to TCP sockets.
#   ## 0 disables keep alive probes.
#   ## Defaults to the OS configuration.
#   # keep_alive_period = "5m"
#
#   ## Content encoding for packet-based connections (i.e. UDP, unixgram).
#   ## Can be set to "gzip" or to "identity" to apply no encoding.
#   ##
#   # content_encoding = "identity"
#
#   ## Data format to generate.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   # data_format = "influx"


# # Send metrics to SQL Database
# [[outputs.sql]]
#   ## Database driver
#   ## Valid options: mssql (Microsoft SQL Server), mysql (MySQL), pgx (Postgres),
#   ##  sqlite (SQLite3), snowflake (snowflake.com) clickhouse (ClickHouse)
#   # driver = ""
#
#   ## Data source name
#   ## The format of the data source name is different for each database driver.
#   ## See the plugin readme for details.
#   # data_source_name = ""
#
#   ## Timestamp column name
#   # timestamp_column = "timestamp"
#
#   ## Table creation template
#   ## Available template variables:
#   ##  {TABLE} - table name as a quoted identifier
#   ##  {TABLELITERAL} - table name as a quoted string literal
#   ##  {COLUMNS} - column definitions (list of quoted identifiers and types)
#   # table_template = "CREATE TABLE {TABLE}({COLUMNS})"
#
#   ## Table existence check template
#   ## Available template variables:
#   ##  {TABLE} - tablename as a quoted identifier
#   # table_exists_template = "SELECT 1 FROM {TABLE} LIMIT 1"
#
#   ## Initialization SQL
#   # init_sql = ""
#
#   ## Metric type to SQL type conversion
#   ## The values on the left are the data types Telegraf has and the values on
#   ## the right are the data types Telegraf will use when sending to a database.
#   ##
#   ## The database values used must be data types the destination database
#   ## understands. It is up to the user to ensure that the selected data type is
#   ## available in the database they are using. Refer to your database
#   ## documentation for what data types are available and supported.
#   #[outputs.sql.convert]
#   #  integer              = "INT"
#   #  real                 = "DOUBLE"
#   #  text                 = "TEXT"
#   #  timestamp            = "TIMESTAMP"
#   #  defaultvalue         = "TEXT"
#   #  unsigned             = "UNSIGNED"
#   #  bool                 = "BOOL"
#
#   ## This setting controls the behavior of the unsigned value. By default the
#   ## setting will take the integer value and append the unsigned value to it. The other
#   ## option is "literal", which will use the actual value the user provides to
#   ## the unsigned option. This is useful for a database like ClickHouse where
#   ## the unsigned value should use a value like "uint64".
#   # conversion_style = "unsigned_suffix"


# # Configuration for Google Cloud Stackdriver to send metrics to
# [[outputs.stackdriver]]
#   ## GCP Project
#   project = "erudite-bloom-151019"
#
#   ## The namespace for the metric descriptor
#   namespace = "telegraf"
#
#   ## Custom resource type
#   # resource_type = "generic_node"
#
#   ## Additional resource labels
#   # [outputs.stackdriver.resource_labels]
#   #   node_id = "$HOSTNAME"
#   #   namespace = "myapp"
#   #   location = "eu-north0"


# # A plugin that can transmit metrics to Sumo Logic HTTP Source
# [[outputs.sumologic]]
#   ## Unique URL generated for your HTTP Metrics Source.
#   ## This is the address to send metrics to.
#   # url = "https://events.sumologic.net/receiver/v1/http/<UniqueHTTPCollectorCode>"
#
#   ## Data format to be used for sending metrics.
#   ## This will set the "Content-Type" header accordingly.
#   ## Currently supported formats:
#   ## * graphite - for Content-Type of application/vnd.sumologic.graphite
#   ## * carbon2 - for Content-Type of application/vnd.sumologic.carbon2
#   ## * prometheus - for Content-Type of application/vnd.sumologic.prometheus
#   ##
#   ## More information can be found at:
#   ## https://help.sumologic.com/03Send-Data/Sources/02Sources-for-Hosted-Collectors/HTTP-Source/Upload-Metrics-to-an-HTTP-Source#content-type-headers-for-metrics
#   ##
#   ## NOTE:
#   ## When unset, telegraf will by default use the influx serializer which is currently unsupported
#   ## in HTTP Source.
#   data_format = "carbon2"
#
#   ## Timeout used for HTTP request
#   # timeout = "5s"
#
#   ## Max HTTP request body size in bytes before compression (if applied).
#   ## By default 1MB is recommended.
#   ## NOTE:
#   ## Bear in mind that in some serializer a metric even though serialized to multiple
#   ## lines cannot be split any further so setting this very low might not work
#   ## as expected.
#   # max_request_body_size = 1000000
#
#   ## Additional, Sumo specific options.
#   ## Full list can be found here:
#   ## https://help.sumologic.com/03Send-Data/Sources/02Sources-for-Hosted-Collectors/HTTP-Source/Upload-Metrics-to-an-HTTP-Source#supported-http-headers
#
#   ## Desired source name.
#   ## Useful if you want to override the source name configured for the source.
#   # source_name = ""
#
#   ## Desired host name.
#   ## Useful if you want to override the source host configured for the source.
#   # source_host = ""
#
#   ## Desired source category.
#   ## Useful if you want to override the source category configured for the source.
#   # source_category = ""
#
#   ## Comma-separated key=value list of dimensions to apply to every metric.
#   ## Custom dimensions will allow you to query your metrics at a more granular level.
#   # dimensions = ""


# # Configuration for Syslog server to send metrics to
# [[outputs.syslog]]
#   ## URL to connect to
#   ## ex: address = "tcp://127.0.0.1:8094"
#   ## ex: address = "tcp4://127.0.0.1:8094"
#   ## ex: address = "tcp6://127.0.0.1:8094"
#   ## ex: address = "tcp6://[2001:db8::1]:8094"
#   ## ex: address = "udp://127.0.0.1:8094"
#   ## ex: address = "udp4://127.0.0.1:8094"
#   ## ex: address = "udp6://127.0.0.1:8094"
#   address = "tcp://127.0.0.1:8094"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## Period between keep alive probes.
#   ## Only applies to TCP sockets.
#   ## 0 disables keep alive probes.
#   ## Defaults to the OS configuration.
#   # keep_alive_period = "5m"
#
#   ## The framing technique with which it is expected that messages are
#   ## transported (default = "octet-counting").  Whether the messages come
#   ## using the octect-counting (RFC5425#section-4.3.1, RFC6587#section-3.4.1),
#   ## or the non-transparent framing technique (RFC6587#section-3.4.2).  Must
#   ## be one of "octet-counting", "non-transparent".
#   # framing = "octet-counting"
#
#   ## The trailer to be expected in case of non-transparent framing (default = "LF").
#   ## Must be one of "LF", or "NUL".
#   # trailer = "LF"
#
#   ## SD-PARAMs settings
#   ## Syslog messages can contain key/value pairs within zero or more
#   ## structured data sections.  For each unrecognized metric tag/field a
#   ## SD-PARAMS is created.
#   ##
#   ## Example:
#   ##   [[outputs.syslog]]
#   ##     sdparam_separator = "_"
#   ##     default_sdid = "default@32473"
#   ##     sdids = ["foo@123", "bar@456"]
#   ##
#   ##   input => xyzzy,x=y foo@123_value=42,bar@456_value2=84,something_else=1
#   ##   output (structured data only) => [foo@123 value=42][bar@456 value2=84][default@32473 something_else=1 x=y]
#
#   ## SD-PARAMs separator between the sdid and tag/field key (default = "_")
#   # sdparam_separator = "_"
#
#   ## Default sdid used for tags/fields that don't contain a prefix defined in
#   ## the explicit sdids setting below If no default is specified, no SD-PARAMs
#   ## will be used for unrecognized field.
#   # default_sdid = "default@32473"
#
#   ## List of explicit prefixes to extract from tag/field keys and use as the
#   ## SDID, if they match (see above example for more details):
#   # sdids = ["foo@123", "bar@456"]
#
#   ## Default severity value. Severity and Facility are used to calculate the
#   ## message PRI value (RFC5424#section-6.2.1).  Used when no metric field
#   ## with key "severity_code" is defined.  If unset, 5 (notice) is the default
#   # default_severity_code = 5
#
#   ## Default facility value. Facility and Severity are used to calculate the
#   ## message PRI value (RFC5424#section-6.2.1).  Used when no metric field with
#   ## key "facility_code" is defined.  If unset, 1 (user-level) is the default
#   # default_facility_code = 1
#
#   ## Default APP-NAME value (RFC5424#section-6.2.5)
#   ## Used when no metric tag with key "appname" is defined.
#   ## If unset, "Telegraf" is the default
#   # default_appname = "Telegraf"


# # Configuration for Amazon Timestream output.
# [[outputs.timestream]]
#   ## Amazon Region
#   region = "us-east-1"
#
#   ## Amazon Credentials
#   ## Credentials are loaded in the following order:
#   ## 1) Web identity provider credentials via STS if role_arn and web_identity_token_file are specified
#   ## 2) Assumed credentials via STS if role_arn is specified
#   ## 3) explicit credentials from 'access_key' and 'secret_key'
#   ## 4) shared profile from 'profile'
#   ## 5) environment variables
#   ## 6) shared credentials file
#   ## 7) EC2 Instance Profile
#   #access_key = ""
#   #secret_key = ""
#   #token = ""
#   #role_arn = ""
#   #web_identity_token_file = ""
#   #role_session_name = ""
#   #profile = ""
#   #shared_credential_file = ""
#
#   ## Endpoint to make request against, the correct endpoint is automatically
#   ## determined and this option should only be set if you wish to override the
#   ## default.
#   ##   ex: endpoint_url = "http://localhost:8000"
#   # endpoint_url = ""
#
#   ## Timestream database where the metrics will be inserted.
#   ## The database must exist prior to starting Telegraf.
#   database_name = "yourDatabaseNameHere"
#
#   ## Specifies if the plugin should describe the Timestream database upon starting
#   ## to validate if it has access necessary permissions, connection, etc., as a safety check.
#   ## If the describe operation fails, the plugin will not start
#   ## and therefore the Telegraf agent will not start.
#   describe_database_on_start = false
#
#   ## The mapping mode specifies how Telegraf records are represented in Timestream.
#   ## Valid values are: single-table, multi-table.
#   ## For example, consider the following data in line protocol format:
#   ## weather,location=us-midwest,season=summer temperature=82,humidity=71 1465839830100400200
#   ## airquality,location=us-west no2=5,pm25=16 1465839830100400200
#   ## where weather and airquality are the measurement names, location and season are tags,
#   ## and temperature, humidity, no2, pm25 are fields.
#   ## In multi-table mode:
#   ##  - first line will be ingested to table named weather
#   ##  - second line will be ingested to table named airquality
#   ##  - the tags will be represented as dimensions
#   ##  - first table (weather) will have two records:
#   ##      one with measurement name equals to temperature,
#   ##      another with measurement name equals to humidity
#   ##  - second table (airquality) will have two records:
#   ##      one with measurement name equals to no2,
#   ##      another with measurement name equals to pm25
#   ##  - the Timestream tables from the example will look like this:
#   ##      TABLE "weather":
#   ##        time | location | season | measure_name | measure_value::bigint
#   ##        2016-06-13 17:43:50 | us-midwest | summer | temperature | 82
#   ##        2016-06-13 17:43:50 | us-midwest | summer | humidity | 71
#   ##      TABLE "airquality":
#   ##        time | location | measure_name | measure_value::bigint
#   ##        2016-06-13 17:43:50 | us-west | no2 | 5
#   ##        2016-06-13 17:43:50 | us-west | pm25 | 16
#   ## In single-table mode:
#   ##  - the data will be ingested to a single table, which name will be valueOf(single_table_name)
#   ##  - measurement name will stored in dimension named valueOf(single_table_dimension_name_for_telegraf_measurement_name)
#   ##  - location and season will be represented as dimensions
#   ##  - temperature, humidity, no2, pm25 will be represented as measurement name
#   ##  - the Timestream table from the example will look like this:
#   ##      Assuming:
#   ##        - single_table_name = "my_readings"
#   ##        - single_table_dimension_name_for_telegraf_measurement_name = "namespace"
#   ##      TABLE "my_readings":
#   ##        time | location | season | namespace | measure_name | measure_value::bigint
#   ##        2016-06-13 17:43:50 | us-midwest | summer | weather | temperature | 82
#   ##        2016-06-13 17:43:50 | us-midwest | summer | weather | humidity | 71
#   ##        2016-06-13 17:43:50 | us-west | NULL | airquality | no2 | 5
#   ##        2016-06-13 17:43:50 | us-west | NULL | airquality | pm25 | 16
#   ## In most cases, using multi-table mapping mode is recommended.
#   ## However, you can consider using single-table in situations when you have thousands of measurement names.
#   mapping_mode = "multi-table"
#
#   ## Only valid and required for mapping_mode = "single-table"
#   ## Specifies the Timestream table where the metrics will be uploaded.
#   # single_table_name = "yourTableNameHere"
#
#   ## Only valid and required for mapping_mode = "single-table"
#   ## Describes what will be the Timestream dimension name for the Telegraf
#   ## measurement name.
#   # single_table_dimension_name_for_telegraf_measurement_name = "namespace"
#
#   ## Specifies if the plugin should create the table, if the table do not exist.
#   ## The plugin writes the data without prior checking if the table exists.
#   ## When the table does not exist, the error returned from Timestream will cause
#   ## the plugin to create the table, if this parameter is set to true.
#   create_table_if_not_exists = true
#
#   ## Only valid and required if create_table_if_not_exists = true
#   ## Specifies the Timestream table magnetic store retention period in days.
#   ## Check Timestream documentation for more details.
#   create_table_magnetic_store_retention_period_in_days = 365
#
#   ## Only valid and required if create_table_if_not_exists = true
#   ## Specifies the Timestream table memory store retention period in hours.
#   ## Check Timestream documentation for more details.
#   create_table_memory_store_retention_period_in_hours = 24
#
#   ## Only valid and optional if create_table_if_not_exists = true
#   ## Specifies the Timestream table tags.
#   ## Check Timestream documentation for more details
#   # create_table_tags = { "foo" = "bar", "environment" = "dev"}
#
#   ## Specify the maximum number of parallel go routines to ingest/write data
#   ## If not specified, defaulted to 1 go routines
#   max_write_go_routines = 25


# # Write metrics to Warp 10
# [[outputs.warp10]]
#   # Prefix to add to the measurement.
#   prefix = "telegraf."
#
#   # URL of the Warp 10 server
#   warp_url = "http://localhost:8080"
#
#   # Write token to access your app on warp 10
#   token = "Token"
#
#   # Warp 10 query timeout
#   # timeout = "15s"
#
#   ## Print Warp 10 error body
#   # print_error_body = false
#
#   ## Max string error size
#   # max_string_error_size = 511
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Configuration for Wavefront server to send metrics to
# [[outputs.wavefront]]
#   ## Url for Wavefront Direct Ingestion. For Wavefront Proxy Ingestion, see
#   ## the 'host' and 'port' optioins below.
#   url = "https://metrics.wavefront.com"
#
#   ## Authentication Token for Wavefront. Only required if using Direct Ingestion
#   #token = "DUMMY_TOKEN"
#
#   ## DNS name of the wavefront proxy server. Do not use if url is specified
#   #host = "wavefront.example.com"
#
#   ## Port that the Wavefront proxy server listens on. Do not use if url is specified
#   #port = 2878
#
#   ## prefix for metrics keys
#   #prefix = "my.specific.prefix."
#
#   ## whether to use "value" for name of simple fields. default is false
#   #simple_fields = false
#
#   ## character to use between metric and field name.  default is . (dot)
#   #metric_separator = "."
#
#   ## Convert metric name paths to use metricSeparator character
#   ## When true will convert all _ (underscore) characters in final metric name. default is true
#   #convert_paths = true
#
#   ## Use Strict rules to sanitize metric and tag names from invalid characters
#   ## When enabled forward slash (/) and comma (,) will be accepted
#   #use_strict = false
#
#   ## Use Regex to sanitize metric and tag names from invalid characters
#   ## Regex is more thorough, but significantly slower. default is false
#   #use_regex = false
#
#   ## point tags to use as the source name for Wavefront (if none found, host will be used)
#   #source_override = ["hostname", "address", "agent_host", "node_host"]
#
#   ## whether to convert boolean values to numeric values, with false -> 0.0 and true -> 1.0. default is true
#   #convert_bool = true
#
#   ## Truncate metric tags to a total of 254 characters for the tag name value. Wavefront will reject any
#   ## data point exceeding this limit if not truncated. Defaults to 'false' to provide backwards compatibility.
#   #truncate_tags = false
#
#   ## Flush the internal buffers after each batch. This effectively bypasses the background sending of metrics
#   ## normally done by the Wavefront SDK. This can be used if you are experiencing buffer overruns. The sending
#   ## of metrics will block for a longer time, but this will be handled gracefully by the internal buffering in
#   ## Telegraf.
#   #immediate_flush = true


# # Generic WebSocket output writer.
# [[outputs.websocket]]
#   ## URL is the address to send metrics to. Make sure ws or wss scheme is used.
#   url = "ws://127.0.0.1:8080/telegraf"
#
#   ## Timeouts (make sure read_timeout is larger than server ping interval or set to zero).
#   # connect_timeout = "30s"
#   # write_timeout = "30s"
#   # read_timeout = "30s"
#
#   ## Optionally turn on using text data frames (binary by default).
#   # use_text_frames = false
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## Optional SOCKS5 proxy to use
#   # socks5_enabled = true
#   # socks5_address = "127.0.0.1:1080"
#   # socks5_username = "alice"
#   # socks5_password = "pass123"
#
#   ## Data format to output.
#   ## Each data format has it's own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_OUTPUT.md
#   # data_format = "influx"
#
#   ## Additional HTTP Upgrade headers
#   # [outputs.websocket.headers]
#   #   Authorization = "Bearer <TOKEN>"


# # Send aggregated metrics to Yandex.Cloud Monitoring
# [[outputs.yandex_cloud_monitoring]]
#   ## Timeout for HTTP writes.
#   # timeout = "20s"
#
#   ## Yandex.Cloud monitoring API endpoint. Normally should not be changed
#   # endpoint_url = "https://monitoring.api.cloud.yandex.net/monitoring/v2/data/write"
#
#   ## All user metrics should be sent with "custom" service specified. Normally should not be changed
#   # service = "custom"


###############################################################################
#                            PROCESSOR PLUGINS                                #
###############################################################################


# # Attach AWS EC2 metadata to metrics
# [[processors.aws_ec2]]
#   ## Instance identity document tags to attach to metrics.
#   ## For more information see:
#   ## https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html
#   ##
#   ## Available tags:
#   ## * accountId
#   ## * architecture
#   ## * availabilityZone
#   ## * billingProducts
#   ## * imageId
#   ## * instanceId
#   ## * instanceType
#   ## * kernelId
#   ## * pendingTime
#   ## * privateIp
#   ## * ramdiskId
#   ## * region
#   ## * version
#   imds_tags = []
#
#   ## EC2 instance tags retrieved with DescribeTags action.
#   ## In case tag is empty upon retrieval it's omitted when tagging metrics.
#   ## Note that in order for this to work, role attached to EC2 instance or AWS
#   ## credentials available from the environment must have a policy attached, that
#   ## allows ec2:DescribeTags.
#   ##
#   ## For more information see:
#   ## https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeTags.html
#   ec2_tags = []
#
#   ## Timeout for http requests made by against aws ec2 metadata endpoint.
#   timeout = "10s"
#
#   ## ordered controls whether or not the metrics need to stay in the same order
#   ## this plugin received them in. If false, this plugin will change the order
#   ## with requests hitting cached results moving through immediately and not
#   ## waiting on slower lookups. This may cause issues for you if you are
#   ## depending on the order of metrics staying the same. If so, set this to true.
#   ## Keeping the metrics ordered may be slightly slower.
#   ordered = false
#
#   ## max_parallel_calls is the maximum number of AWS API calls to be in flight
#   ## at the same time.
#   ## It's probably best to keep this number fairly low.
#   max_parallel_calls = 10


# # Clone metrics and apply modifications.
# [[processors.clone]]
#   ## All modifications on inputs and aggregators can be overridden:
#   # name_override = "new_name"
#   # name_prefix = "new_name_prefix"
#   # name_suffix = "new_name_suffix"
#
#   ## Tags to be added (all values must be strings)
#   # [processors.clone.tags]
#   #   additional_tag = "tag_value"


# # Convert values to another metric value type
# [[processors.converter]]
#   ## Tags to convert
#   ##
#   ## The table key determines the target type, and the array of key-values
#   ## select the keys to convert.  The array may contain globs.
#   ##   <target-type> = [<tag-key>...]
#   [processors.converter.tags]
#     measurement = []
#     string = []
#     integer = []
#     unsigned = []
#     boolean = []
#     float = []
#
#   ## Fields to convert
#   ##
#   ## The table key determines the target type, and the array of key-values
#   ## select the keys to convert.  The array may contain globs.
#   ##   <target-type> = [<field-key>...]
#   [processors.converter.fields]
#     measurement = []
#     tag = []
#     string = []
#     integer = []
#     unsigned = []
#     boolean = []
#     float = []


# # Dates measurements, tags, and fields that pass through this filter.
# [[processors.date]]
# 	## New tag to create
# 	tag_key = "month"
#
# 	## New field to create (cannot set both field_key and tag_key)
# 	# field_key = "month"
#
# 	## Date format string, must be a representation of the Go "reference time"
# 	## which is "Mon Jan 2 15:04:05 -0700 MST 2006".
# 	date_format = "Jan"
#
# 	## If destination is a field, date format can also be one of
# 	## "unix", "unix_ms", "unix_us", or "unix_ns", which will insert an integer field.
# 	# date_format = "unix"
#
# 	## Offset duration added to the date string when writing the new tag.
# 	# date_offset = "0s"
#
# 	## Timezone to use when creating the tag or field using a reference time
# 	## string.  This can be set to one of "UTC", "Local", or to a location name
# 	## in the IANA Time Zone database.
# 	##   example: timezone = "America/Los_Angeles"
# 	# timezone = "UTC"


# # Filter metrics with repeating field values
# [[processors.dedup]]
#   ## Maximum time to suppress output
#   dedup_interval = "600s"


# # Defaults sets default value(s) for specified fields that are not set on incoming metrics.
# [[processors.defaults]]
#   ## Ensures a set of fields always exists on your metric(s) with their
#   ## respective default value.
#   ## For any given field pair (key = default), if it's not set, a field
#   ## is set on the metric with the specified default.
#   ##
#   ## A field is considered not set if it is nil on the incoming metric;
#   ## or it is not nil but its value is an empty string or is a string
#   ## of one or more spaces.
#   ##   <target-field> = <value>
#   # [processors.defaults.fields]
#   #   field_1 = "bar"
#   #   time_idle = 0
#   #   is_error = true


# # Map enum values according to given table.
# [[processors.enum]]
#   [[processors.enum.mapping]]
#     ## Name of the field to map. Globs accepted.
#     field = "status"
#
#     ## Name of the tag to map. Globs accepted.
#     # tag = "status"
#
#     ## Destination tag or field to be used for the mapped value.  By default the
#     ## source tag or field is used, overwriting the original value.
#     dest = "status_code"
#
#     ## Default value to be used for all values not contained in the mapping
#     ## table.  When unset, the unmodified value for the field will be used if no
#     ## match is found.
#     # default = 0
#
#     ## Table of mappings
#     [processors.enum.mapping.value_mappings]
#       green = 1
#       amber = 2
#       red = 3


# # Run executable as long-running processor plugin
# [[processors.execd]]
# 	## Program to run as daemon
# 	## eg: command = ["/path/to/your_program", "arg1", "arg2"]
# 	command = ["cat"]
#
#   ## Delay before the process is restarted after an unexpected termination
#   restart_delay = "10s"


# # Performs file path manipulations on tags and fields
# [[processors.filepath]]
#   ## Treat the tag value as a path and convert it to its last element, storing the result in a new tag
#   # [[processors.filepath.basename]]
#   #   tag = "path"
#   #   dest = "basepath"
#
#   ## Treat the field value as a path and keep all but the last element of path, typically the path's directory
#   # [[processors.filepath.dirname]]
#   #   field = "path"
#
#   ## Treat the tag value as a path, converting it to its the last element without its suffix
#   # [[processors.filepath.stem]]
#   #   tag = "path"
#
#   ## Treat the tag value as a path, converting it to the shortest path name equivalent
#   ## to path by purely lexical processing
#   # [[processors.filepath.clean]]
#   #   tag = "path"
#
#   ## Treat the tag value as a path, converting it to a relative path that is lexically
#   ## equivalent to the source path when joined to 'base_path'
#   # [[processors.filepath.rel]]
#   #   tag = "path"
#   #   base_path = "/var/log"
#
#   ## Treat the tag value as a path, replacing each separator character in path with a '/' character. Has only
#   ## effect on Windows
#   # [[processors.filepath.toslash]]
#   #   tag = "path"


# # Add a tag of the network interface name looked up over SNMP by interface number
# [[processors.ifname]]
#   ## Name of tag holding the interface number
#   # tag = "ifIndex"
#
#   ## Name of output tag where service name will be added
#   # dest = "ifName"
#
#   ## Name of tag of the SNMP agent to request the interface name from
#   # agent = "agent"
#
#   ## Timeout for each request.
#   # timeout = "5s"
#
#   ## SNMP version; can be 1, 2, or 3.
#   # version = 2
#
#   ## SNMP community string.
#   # community = "public"
#
#   ## Number of retries to attempt.
#   # retries = 3
#
#   ## The GETBULK max-repetitions parameter.
#   # max_repetitions = 10
#
#   ## SNMPv3 authentication and encryption options.
#   ##
#   ## Security Name.
#   # sec_name = "myuser"
#   ## Authentication protocol; one of "MD5", "SHA", or "".
#   # auth_protocol = "MD5"
#   ## Authentication password.
#   # auth_password = "pass"
#   ## Security Level; one of "noAuthNoPriv", "authNoPriv", or "authPriv".
#   # sec_level = "authNoPriv"
#   ## Context Name.
#   # context_name = ""
#   ## Privacy protocol used for encrypted messages; one of "DES", "AES" or "".
#   # priv_protocol = ""
#   ## Privacy password used for encrypted messages.
#   # priv_password = ""
#
#   ## max_parallel_lookups is the maximum number of SNMP requests to
#   ## make at the same time.
#   # max_parallel_lookups = 100
#
#   ## ordered controls whether or not the metrics need to stay in the
#   ## same order this plugin received them in. If false, this plugin
#   ## may change the order when data is cached.  If you need metrics to
#   ## stay in order set this to true.  keeping the metrics ordered may
#   ## be slightly slower
#   # ordered = false
#
#   ## cache_ttl is the amount of time interface names are cached for a
#   ## given agent.  After this period elapses if names are needed they
#   ## will be retrieved again.
#   # cache_ttl = "8h"


# # Adds noise to numerical fields
# [[processors.noise]]
#     ## Specified the type of the random distribution.
#     ## Can be "laplacian", "gaussian" or "uniform".
#     # type = "laplacian
#
#     ## Center of the distribution.
#     ## Only used for Laplacian and Gaussian distributions.
#     # mu = 0.0
#
#     ## Scale parameter for the Laplacian or Gaussian distribution
#     # scale = 1.0
#
#     ## Upper and lower bound of the Uniform distribution
#     # min = -1.0
#     # max = 1.0
#
#     ## Apply the noise only to numeric fields matching the filter criteria below.
#     ## Excludes takes precedence over includes.
#     # include_fields = []
#     # exclude_fields = []


# # Apply metric modifications using override semantics.
# [[processors.override]]
#   ## All modifications on inputs and aggregators can be overridden:
#   # name_override = "new_name"
#   # name_prefix = "new_name_prefix"
#   # name_suffix = "new_name_suffix"
#
#   ## Tags to be added (all values must be strings)
#   # [processors.override.tags]
#   #   additional_tag = "tag_value"


# # Parse a value in a specified field/tag(s) and add the result in a new metric
# [[processors.parser]]
#   ## The name of the fields whose value will be parsed.
#   parse_fields = []
#
#   ## If true, incoming metrics are not emitted.
#   drop_original = false
#
#   ## If set to override, emitted metrics will be merged by overriding the
#   ## original metric using the newly parsed metrics.
#   merge = "override"
#
#   ## The dataformat to be read from files
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   data_format = "influx"


# # Rotate a single valued metric into a multi field metric
# [[processors.pivot]]
#   ## Tag to use for naming the new field.
#   tag_key = "name"
#   ## Field to use as the value of the new field.
#   value_key = "value"


# # Given a tag/field of a TCP or UDP port number, add a tag/field of the service name looked up in the system services file
# [[processors.port_name]]
# [[processors.port_name]]
#   ## Name of tag holding the port number
#   # tag = "port"
#   ## Or name of the field holding the port number
#   # field = "port"
#
#   ## Name of output tag or field (depending on the source) where service name will be added
#   # dest = "service"
#
#   ## Default tcp or udp
#   # default_protocol = "tcp"
#
#   ## Tag containing the protocol (tcp or udp, case-insensitive)
#   # protocol_tag = "proto"
#
#   ## Field containing the protocol (tcp or udp, case-insensitive)
#   # protocol_field = "proto"


# # Print all metrics that pass through this filter.
# [[processors.printer]]


# # Transforms tag and field values as well as measurement, tag and field names with regex pattern
# [[processors.regex]]
#   ## Tag and field conversions defined in a separate sub-tables
#   # [[processors.regex.tags]]
#   #   ## Tag to change
#   #   key = "resp_code"
#   #   ## Regular expression to match on a tag value
#   #   pattern = "^(\\d)\\d\\d$"
#   #   ## Matches of the pattern will be replaced with this string.  Use ${1}
#   #   ## notation to use the text of the first submatch.
#   #   replacement = "${1}xx"
#
#   # [[processors.regex.fields]]
#   #   ## Field to change
#   #   key = "request"
#   #   ## All the power of the Go regular expressions available here
#   #   ## For example, named subgroups
#   #   pattern = "^/api(?P<method>/[\\w/]+)\\S*"
#   #   replacement = "${method}"
#   #   ## If result_key is present, a new field will be created
#   #   ## instead of changing existing field
#   #   result_key = "method"
#
#   ## Multiple conversions may be applied for one field sequentially
#   ## Let's extract one more value
#   # [[processors.regex.fields]]
#   #   key = "request"
#   #   pattern = ".*category=(\\w+).*"
#   #   replacement = "${1}"
#   #   result_key = "search_category"
#
#   ## Rename metric fields
#   # [[processors.regex.field_rename]]
#   #   ## Regular expression to match on a field name
#   #   pattern = "^search_(\\w+)d$"
#   #   ## Matches of the pattern will be replaced with this string.  Use ${1}
#   #   ## notation to use the text of the first submatch.
#   #   replacement = "${1}"
#   #   ## If the new field name already exists, you can either "overwrite" the
#   #   ## existing one with the value of the renamed field OR you can "keep"
#   #   ## both the existing and source field.
#   #   # result_key = "keep"
#
#   ## Rename metric tags
#   # [[processors.regex.tag_rename]]
#   #   ## Regular expression to match on a tag name
#   #   pattern = "^search_(\\w+)d$"
#   #   ## Matches of the pattern will be replaced with this string.  Use ${1}
#   #   ## notation to use the text of the first submatch.
#   #   replacement = "${1}"
#   #   ## If the new tag name already exists, you can either "overwrite" the
#   #   ## existing one with the value of the renamed tag OR you can "keep"
#   #   ## both the existing and source tag.
#   #   # result_key = "keep"
#
#   ## Rename metrics
#   # [[processors.regex.metric_rename]]
#   #   ## Regular expression to match on an metric name
#   #   pattern = "^search_(\\w+)d$"
#   #   ## Matches of the pattern will be replaced with this string.  Use ${1}
#   #   ## notation to use the text of the first submatch.
#   #   replacement = "${1}"


# # Rename measurements, tags, and fields that pass through this filter.
# [[processors.rename]]


# # ReverseDNS does a reverse lookup on IP addresses to retrieve the DNS name
# [[processors.reverse_dns]]
#   ## For optimal performance, you may want to limit which metrics are passed to this
#   ## processor. eg:
#   ## namepass = ["my_metric_*"]
#
#   ## cache_ttl is how long the dns entries should stay cached for.
#   ## generally longer is better, but if you expect a large number of diverse lookups
#   ## you'll want to consider memory use.
#   cache_ttl = "24h"
#
#   ## lookup_timeout is how long should you wait for a single dns request to repsond.
#   ## this is also the maximum acceptable latency for a metric travelling through
#   ## the reverse_dns processor. After lookup_timeout is exceeded, a metric will
#   ## be passed on unaltered.
#   ## multiple simultaneous resolution requests for the same IP will only make a
#   ## single rDNS request, and they will all wait for the answer for this long.
#   lookup_timeout = "3s"
#
#   ## max_parallel_lookups is the maximum number of dns requests to be in flight
#   ## at the same time. Requesting hitting cached values do not count against this
#   ## total, and neither do mulptiple requests for the same IP.
#   ## It's probably best to keep this number fairly low.
#   max_parallel_lookups = 10
#
#   ## ordered controls whether or not the metrics need to stay in the same order
#   ## this plugin received them in. If false, this plugin will change the order
#   ## with requests hitting cached results moving through immediately and not
#   ## waiting on slower lookups. This may cause issues for you if you are
#   ## depending on the order of metrics staying the same. If so, set this to true.
#   ## keeping the metrics ordered may be slightly slower.
#   ordered = false
#
#   [[processors.reverse_dns.lookup]]
#     ## get the ip from the field "source_ip", and put the result in the field "source_name"
#     field = "source_ip"
#     dest = "source_name"
#
#   [[processors.reverse_dns.lookup]]
#     ## get the ip from the tag "destination_ip", and put the result in the tag
#     ## "destination_name".
#     tag = "destination_ip"
#     dest = "destination_name"
#
#     ## If you would prefer destination_name to be a field instead, you can use a
#     ## processors.converter after this one, specifying the order attribute.


# # Add the S2 Cell ID as a tag based on latitude and longitude fields
# [[processors.s2geo]]
#   ## The name of the lat and lon fields containing WGS-84 latitude and
#   ## longitude in decimal degrees.
#   # lat_field = "lat"
#   # lon_field = "lon"
#
#   ## New tag to create
#   # tag_key = "s2_cell_id"
#
#   ## Cell level (see https://s2geometry.io/resources/s2cell_statistics.html)
#   # cell_level = 9


# # Process metrics using a Starlark script
# [[processors.starlark]]
#   ## The Starlark source can be set as a string in this configuration file, or
#   ## by referencing a file containing the script.  Only one source or script
#   ## should be set at once.
#   ##
#   ## Source of the Starlark script.
#   source = '''
# def apply(metric):
# 	return metric
# '''
#
#   ## File containing a Starlark script.
#   # script = "/usr/local/bin/myscript.star"
#
#   ## The constants of the Starlark script.
#   # [processors.starlark.constants]
#   #   max_size = 10
#   #   threshold = 0.75
#   #   default_name = "Julia"
#   #   debug_mode = true


# # Perform string processing on tags, fields, and measurements
# [[processors.strings]]
#   ## Convert a tag value to uppercase
#   # [[processors.strings.uppercase]]
#   #   tag = "method"
#
#   ## Convert a field value to lowercase and store in a new field
#   # [[processors.strings.lowercase]]
#   #   field = "uri_stem"
#   #   dest = "uri_stem_normalised"
#
#   ## Convert a field value to titlecase
#   # [[processors.strings.titlecase]]
#   #   field = "status"
#
#   ## Trim leading and trailing whitespace using the default cutset
#   # [[processors.strings.trim]]
#   #   field = "message"
#
#   ## Trim leading characters in cutset
#   # [[processors.strings.trim_left]]
#   #   field = "message"
#   #   cutset = "\t"
#
#   ## Trim trailing characters in cutset
#   # [[processors.strings.trim_right]]
#   #   field = "message"
#   #   cutset = "\r\n"
#
#   ## Trim the given prefix from the field
#   # [[processors.strings.trim_prefix]]
#   #   field = "my_value"
#   #   prefix = "my_"
#
#   ## Trim the given suffix from the field
#   # [[processors.strings.trim_suffix]]
#   #   field = "read_count"
#   #   suffix = "_count"
#
#   ## Replace all non-overlapping instances of old with new
#   # [[processors.strings.replace]]
#   #   measurement = "*"
#   #   old = ":"
#   #   new = "_"
#
#   ## Trims strings based on width
#   # [[processors.strings.left]]
#   #   field = "message"
#   #   width = 10
#
#   ## Decode a base64 encoded utf-8 string
#   # [[processors.strings.base64decode]]
#   #   field = "message"
#
#   ## Sanitize a string to ensure it is a valid utf-8 string
#   ## Each run of invalid UTF-8 byte sequences is replaced by the replacement string, which may be empty
#   # [[processors.strings.valid_utf8]]
#   #   field = "message"
#   #   replacement = ""


# # Restricts the number of tags that can pass through this filter and chooses which tags to preserve when over the limit.
# [[processors.tag_limit]]
#   ## Maximum number of tags to preserve
#   limit = 10
#
#   ## List of tags to preferentially preserve
#   keep = ["foo", "bar", "baz"]


# # Uses a Go template to create a new tag
# [[processors.template]]
#   ## Tag to set with the output of the template.
#   tag = "topic"
#
#   ## Go template used to create the tag value.  In order to ease TOML
#   ## escaping requirements, you may wish to use single quotes around the
#   ## template string.
#   template = '{{ .Tag "hostname" }}.{{ .Tag "level" }}'


# # Print all metrics that pass through this filter.
# [[processors.topk]]
#   ## How many seconds between aggregations
#   # period = 10
#
#   ## How many top metrics to return
#   # k = 10
#
#   ## Over which tags should the aggregation be done. Globs can be specified, in
#   ## which case any tag matching the glob will aggregated over. If set to an
#   ## empty list is no aggregation over tags is done
#   # group_by = ['*']
#
#   ## Over which fields are the top k are calculated
#   # fields = ["value"]
#
#   ## What aggregation to use. Options: sum, mean, min, max
#   # aggregation = "mean"
#
#   ## Instead of the top k largest metrics, return the bottom k lowest metrics
#   # bottomk = false
#
#   ## The plugin assigns each metric a GroupBy tag generated from its name and
#   ## tags. If this setting is different than "" the plugin will add a
#   ## tag (which name will be the value of this setting) to each metric with
#   ## the value of the calculated GroupBy tag. Useful for debugging
#   # add_groupby_tag = ""
#
#   ## These settings provide a way to know the position of each metric in
#   ## the top k. The 'add_rank_field' setting allows to specify for which
#   ## fields the position is required. If the list is non empty, then a field
#   ## will be added to each and every metric for each string present in this
#   ## setting. This field will contain the ranking of the group that
#   ## the metric belonged to when aggregated over that field.
#   ## The name of the field will be set to the name of the aggregation field,
#   ## suffixed with the string '_topk_rank'
#   # add_rank_fields = []
#
#   ## These settings provide a way to know what values the plugin is generating
#   ## when aggregating metrics. The 'add_aggregate_field' setting allows to
#   ## specify for which fields the final aggregation value is required. If the
#   ## list is non empty, then a field will be added to each every metric for
#   ## each field present in this setting. This field will contain
#   ## the computed aggregation for the group that the metric belonged to when
#   ## aggregated over that field.
#   ## The name of the field will be set to the name of the aggregation field,
#   ## suffixed with the string '_topk_aggregate'
#   # add_aggregate_fields = []


# # Rotate multi field metric into several single field metrics
# [[processors.unpivot]]
#   ## Tag to use for the name.
#   tag_key = "name"
#   ## Field to use for the name of the value.
#   value_key = "value"


###############################################################################
#                            AGGREGATOR PLUGINS                               #
###############################################################################


# # Keep the aggregate basicstats of each metric passing through.
# [[aggregators.basicstats]]
#   ## The period on which to flush & clear the aggregator.
#   period = "30s"
#
#   ## If true, the original metric will be dropped by the
#   ## aggregator and will not get sent to the output plugins.
#   drop_original = false
#
#   ## Configures which basic stats to push as fields
#   # stats = ["count", "min", "max", "mean", "stdev", "s2", "sum"]


# # Calculates a derivative for every field.
# [[aggregators.derivative]]
# 	## The period in which to flush the aggregator.
# 	period = "30s"
# 	##
# 	## If true, the original metric will be dropped by the
# 	## aggregator and will not get sent to the output plugins.
# 	drop_original = false
# 	##
# 	## This aggregator will estimate a derivative for each field, which is
# 	## contained in both the first and last metric of the aggregation interval.
# 	## Without further configuration the derivative will be calculated with
# 	## respect to the time difference between these two measurements in seconds.
# 	## The formula applied is for every field:
# 	##
# 	##               value_last - value_first
# 	## derivative = --------------------------
# 	##              time_difference_in_seconds
# 	##
# 	## The resulting derivative will be named *fieldname_rate*. The suffix
# 	## "_rate" can be configured by the *suffix* parameter. When using a
# 	## derivation variable you can include its name for more clarity.
# 	# suffix = "_rate"
# 	##
# 	## As an abstraction the derivative can be calculated not only by the time
# 	## difference but by the difference of a field, which is contained in the
# 	## measurement. This field is assumed to be monotonously increasing. This
# 	## feature is used by specifying a *variable*.
# 	## Make sure the specified variable is not filtered and exists in the metrics
# 	## passed to this aggregator!
# 	# variable = ""
# 	##
# 	## When using a field as the derivation parameter the name of that field will
# 	## be used for the resulting derivative, e.g. *fieldname_by_parameter*.
# 	##
# 	## Note, that the calculation is based on the actual timestamp of the
# 	## measurements. When there is only one measurement during that period, the
# 	## measurement will be rolled over to the next period. The maximum number of
# 	## such roll-overs can be configured with a default of 10.
# 	# max_roll_over = 10
# 	##


# # Report the final metric of a series
# [[aggregators.final]]
#   ## The period on which to flush & clear the aggregator.
#   period = "30s"
#   ## If true, the original metric will be dropped by the
#   ## aggregator and will not get sent to the output plugins.
#   drop_original = false
#
#   ## The time that a series is not updated until considering it final.
#   series_timeout = "5m"


# # Create aggregate histograms.
# [[aggregators.histogram]]
#   ## The period in which to flush the aggregator.
#   period = "30s"
#
#   ## If true, the original metric will be dropped by the
#   ## aggregator and will not get sent to the output plugins.
#   drop_original = false
#
#   ## If true, the histogram will be reset on flush instead
#   ## of accumulating the results.
#   reset = false
#
#   ## Whether bucket values should be accumulated. If set to false, "gt" tag will be added.
#   ## Defaults to true.
#   cumulative = true
#
#   ## Expiration interval for each histogram. The histogram will be expired if
#   ## there are no changes in any buckets for this time interval. 0 == no expiration.
#   # expiration_interval = "0m"
#
#   ## If true, aggregated histogram are pushed to output only if it was updated since
#   ## previous push. Defaults to false.
#   # push_only_on_update = false
#
#   ## Example config that aggregates all fields of the metric.
#   # [[aggregators.histogram.config]]
#   #   ## Right borders of buckets (with +Inf implicitly added).
#   #   buckets = [0.0, 15.6, 34.5, 49.1, 71.5, 80.5, 94.5, 100.0]
#   #   ## The name of metric.
#   #   measurement_name = "cpu"
#
#   ## Example config that aggregates only specific fields of the metric.
#   # [[aggregators.histogram.config]]
#   #   ## Right borders of buckets (with +Inf implicitly added).
#   #   buckets = [0.0, 10.0, 20.0, 30.0, 40.0, 50.0, 60.0, 70.0, 80.0, 90.0, 100.0]
#   #   ## The name of metric.
#   #   measurement_name = "diskio"
#   #   ## The concrete fields of metric
#   #   fields = ["io_time", "read_time", "write_time"]


# # Merge metrics into multifield metrics by series key
# [[aggregators.merge]]
#   ## If true, the original metric will be dropped by the
#   ## aggregator and will not get sent to the output plugins.
#   drop_original = true


# # Keep the aggregate min/max of each metric passing through.
# [[aggregators.minmax]]
#   ## General Aggregator Arguments:
#   ## The period on which to flush & clear the aggregator.
#   period = "30s"
#   ## If true, the original metric will be dropped by the
#   ## aggregator and will not get sent to the output plugins.
#   drop_original = false


# # Keep the aggregate quantiles of each metric passing through.
# [[aggregators.quantile]]
#   ## General Aggregator Arguments:
#   ## The period on which to flush & clear the aggregator.
#   period = "30s"
#
#   ## If true, the original metric will be dropped by the
#   ## aggregator and will not get sent to the output plugins.
#   drop_original = false
#
#   ## Quantiles to output in the range [0,1]
#   # quantiles = [0.25, 0.5, 0.75]
#
#   ## Type of aggregation algorithm
#   ## Supported are:
#   ##  "t-digest" -- approximation using centroids, can cope with large number of samples
#   ##  "exact R7" -- exact computation also used by Excel or NumPy (Hyndman & Fan 1996 R7)
#   ##  "exact R8" -- exact computation (Hyndman & Fan 1996 R8)
#   ## NOTE: Do not use "exact" algorithms with large number of samples
#   ##       to not impair performance or memory consumption!
#   # algorithm = "t-digest"
#
#   ## Compression for approximation (t-digest). The value needs to be
#   ## greater or equal to 1.0. Smaller values will result in more
#   ## performance but less accuracy.
#   # compression = 100.0


# # Aggregate metrics using a Starlark script
# [[aggregators.starlark]]
#   ## The Starlark source can be set as a string in this configuration file, or
#   ## by referencing a file containing the script.  Only one source or script
#   ## should be set at once.
#   ##
#   ## Source of the Starlark script.
#   source = '''
# state = {}
#
# def add(metric):
#   state["last"] = metric
#
# def push():
#   return state.get("last")
#
# def reset():
#   state.clear()
# '''
#
#   ## File containing a Starlark script.
#   # script = "/usr/local/bin/myscript.star"
#
#   ## The constants of the Starlark script.
#   # [aggregators.starlark.constants]
#   #   max_size = 10
#   #   threshold = 0.75
#   #   default_name = "Julia"
#   #   debug_mode = true


# # Count the occurrence of values in fields.
# [[aggregators.valuecounter]]
#   ## General Aggregator Arguments:
#   ## The period on which to flush & clear the aggregator.
#   period = "30s"
#   ## If true, the original metric will be dropped by the
#   ## aggregator and will not get sent to the output plugins.
#   drop_original = false
#   ## The fields for which the values will be counted
#   fields = []


###############################################################################
#                            INPUT PLUGINS                                    #
###############################################################################


# Read metrics about cpu usage
[[inputs.cpu]]
  ## Whether to report per-cpu stats or not
  percpu = true
  ## Whether to report total system cpu stats or not
  totalcpu = true
  ## If true, collect raw CPU time metrics
  collect_cpu_time = false
  ## If true, compute and report the sum of all non-idle CPU states
  report_active = false


# Read metrics about disk usage by mount point
[[inputs.disk]]
  ## By default stats will be gathered for all mount points.
  ## Set mount_points will restrict the stats to only the specified mount points.
  # mount_points = ["/"]

  ## Ignore mount points by filesystem type.
  ignore_fs = ["tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "aufs", "squashfs"]


# Read metrics about disk IO by device
[[inputs.diskio]]
  ## By default, telegraf will gather stats for all devices including
  ## disk partitions.
  ## Setting devices will restrict the stats to the specified devices.
  # devices = ["sda", "sdb", "vd*"]
  ## Uncomment the following line if you need disk serial numbers.
  # skip_serial_number = false
  #
  ## On systems which support it, device metadata can be added in the form of
  ## tags.
  ## Currently only Linux is supported via udev properties. You can view
  ## available properties for a device by running:
  ## 'udevadm info -q property -n /dev/sda'
  ## Note: Most, but not all, udev properties can be accessed this way. Properties
  ## that are currently inaccessible include DEVTYPE, DEVNAME, and DEVPATH.
  # device_tags = ["ID_FS_TYPE", "ID_FS_USAGE"]
  #
  ## Using the same metadata source as device_tags, you can also customize the
  ## name of the device via templates.
  ## The 'name_templates' parameter is a list of templates to try and apply to
  ## the device. The template may contain variables in the form of '$PROPERTY' or
  ## '${PROPERTY}'. The first template which does not contain any variables not
  ## present for the device is used as the device name tag.
  ## The typical use case is for LVM volumes, to get the VG/LV name instead of
  ## the near-meaningless DM-0 name.
  # name_templates = ["$ID_FS_LABEL","$DM_VG_NAME/$DM_LV_NAME"]


# Get kernel statistics from /proc/stat
[[inputs.kernel]]
  # no configuration


# Read metrics about memory usage
[[inputs.mem]]
  # no configuration


# Get the number of processes and group them by status
[[inputs.processes]]
  # no configuration


# Read metrics about swap memory usage
[[inputs.swap]]
  # no configuration


# Read metrics about system load & uptime
[[inputs.system]]
  ## Uncomment to remove deprecated metrics.
  # fielddrop = ["uptime_format"]


# # Gather ActiveMQ metrics
# [[inputs.activemq]]
#   ## ActiveMQ WebConsole URL
#   url = "http://127.0.0.1:8161"
#
#   ## Credentials for basic HTTP authentication
#   # username = "admin"
#   # password = "admin"
#
#   ## Required ActiveMQ webadmin root path
#   # webadmin = "admin"
#
#   ## Maximum time to receive response.
#   # response_timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Read stats from aerospike server(s)
# [[inputs.aerospike]]
#   ## Aerospike servers to connect to (with port)
#   ## This plugin will query all namespaces the aerospike
#   ## server has configured and get stats for them.
#   servers = ["localhost:3000"]
#
#   # username = "telegraf"
#   # password = "pa$$word"
#
#   ## Optional TLS Config
#   # enable_tls = false
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   # tls_name = "tlsname"
#   ## If false, skip chain & host verification
#   # insecure_skip_verify = true
#
#   # Feature Options
#   # Add namespace variable to limit the namespaces executed on
#   # Leave blank to do all
#   # disable_query_namespaces = true # default false
#   # namespaces = ["namespace1", "namespace2"]
#
#   # Enable set level telemetry
#   # query_sets = true # default: false
#   # Add namespace set combinations to limit sets executed on
#   # Leave blank to do all sets
#   # sets = ["namespace1/set1", "namespace1/set2", "namespace3"]
#
#   # Histograms
#   # enable_ttl_histogram = true # default: false
#   # enable_object_size_linear_histogram = true # default: false
#
#   # by default, aerospike produces a 100 bucket histogram
#   # this is not great for most graphing tools, this will allow
#   # the ability to squash this to a smaller number of buckets
#   # To have a balanced histogram, the number of buckets chosen
#   # should divide evenly into 100.
#   # num_histogram_buckets = 100 # default: 10


# # Query statistics from AMD Graphics cards using rocm-smi binary
# [[inputs.amd_rocm_smi]]
# ## Optional: path to rocm-smi binary, defaults to $PATH via exec.LookPath
# # bin_path = "/opt/rocm/bin/rocm-smi"
#
# ## Optional: timeout for GPU polling
# # timeout = "5s"


# # Read Apache status information (mod_status)
# [[inputs.apache]]
#   ## An array of URLs to gather from, must be directed at the machine
#   ## readable version of the mod_status page including the auto query string.
#   ## Default is "http://localhost/server-status?auto".
#   urls = ["http://localhost/server-status?auto"]
#
#   ## Credentials for basic HTTP authentication.
#   # username = "myuser"
#   # password = "mypassword"
#
#   ## Maximum time to receive response.
#   # response_timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Monitor APC UPSes connected to apcupsd
# [[inputs.apcupsd]]
#   # A list of running apcupsd server to connect to.
#   # If not provided will default to tcp://127.0.0.1:3551
#   servers = ["tcp://127.0.0.1:3551"]
#
#   ## Timeout for dialing server.
#   timeout = "5s"


# # Gather metrics from Apache Aurora schedulers
# [[inputs.aurora]]
#   ## Schedulers are the base addresses of your Aurora Schedulers
#   schedulers = ["http://127.0.0.1:8081"]
#
#   ## Set of role types to collect metrics from.
#   ##
#   ## The scheduler roles are checked each interval by contacting the
#   ## scheduler nodes; zookeeper is not contacted.
#   # roles = ["leader", "follower"]
#
#   ## Timeout is the max time for total network operations.
#   # timeout = "5s"
#
#   ## Username and password are sent using HTTP Basic Auth.
#   # username = "username"
#   # password = "pa$$word"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Gather Azure Storage Queue metrics
# [[inputs.azure_storage_queue]]
#   ## Required Azure Storage Account name
#   account_name = "mystorageaccount"
#
#   ## Required Azure Storage Account access key
#   account_key = "storageaccountaccesskey"
#
#   ## Set to false to disable peeking age of oldest message (executes faster)
#   # peek_oldest_message_age = true


# # Read metrics of bcache from stats_total and dirty_data
# [[inputs.bcache]]
#   ## Bcache sets path
#   ## If not specified, then default is:
#   bcachePath = "/sys/fs/bcache"
#
#   ## By default, Telegraf gather stats for all bcache devices
#   ## Setting devices will restrict the stats to the specified
#   ## bcache devices.
#   bcacheDevs = ["bcache0"]


# # Collects Beanstalkd server and tubes stats
# [[inputs.beanstalkd]]
#   ## Server to collect data from
#   server = "localhost:11300"
#
#   ## List of tubes to gather stats about.
#   ## If no tubes specified then data gathered for each tube on server reported by list-tubes command
#   tubes = ["notifications"]


# # Read metrics exposed by Beat
# [[inputs.beat]]
#   ## An URL from which to read Beat-formatted JSON
#   ## Default is "http://127.0.0.1:5066".
#   url = "http://127.0.0.1:5066"
#
#   ## Enable collection of the listed stats
#   ## An empty list means collect all. Available options are currently
#   ## "beat", "libbeat", "system" and "filebeat".
#   # include = ["beat", "libbeat", "filebeat"]
#
#   ## HTTP method
#   # method = "GET"
#
#   ## Optional HTTP headers
#   # headers = {"X-Special-Header" = "Special-Value"}
#
#   ## Override HTTP "Host" header
#   # host_header = "logstash.example.com"
#
#   ## Timeout for HTTP requests
#   # timeout = "5s"
#
#   ## Optional HTTP Basic Auth credentials
#   # username = "username"
#   # password = "pa$$word"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Read BIND nameserver XML statistics
# [[inputs.bind]]
#   ## An array of BIND XML statistics URI to gather stats.
#   ## Default is "http://localhost:8053/xml/v3".
#   # urls = ["http://localhost:8053/xml/v3"]
#   # gather_memory_contexts = false
#   # gather_views = false
#
#   ## Timeout for http requests made by bind nameserver
#   # timeout = "4s"


# # Collect bond interface status, slaves statuses and failures count
# [[inputs.bond]]
#   ## Sets 'proc' directory path
#   ## If not specified, then default is /proc
#   # host_proc = "/proc"
#
#   ## Sets 'sys' directory path
#   ## If not specified, then default is /sys
#   # host_sys = "/sys"
#
#   ## By default, telegraf gather stats for all bond interfaces
#   ## Setting interfaces will restrict the stats to the specified
#   ## bond interfaces.
#   # bond_interfaces = ["bond0"]
#
#   ## Tries to collect additional bond details from /sys/class/net/{bond}
#   ## currently only useful for LACP (mode 4) bonds
#   # collect_sys_details = false
#


# # Collect Kafka topics and consumers status from Burrow HTTP API.
# [[inputs.burrow]]
#   ## Burrow API endpoints in format "schema://host:port".
#   ## Default is "http://localhost:8000".
#   servers = ["http://localhost:8000"]
#
#   ## Override Burrow API prefix.
#   ## Useful when Burrow is behind reverse-proxy.
#   # api_prefix = "/v3/kafka"
#
#   ## Maximum time to receive response.
#   # response_timeout = "5s"
#
#   ## Limit per-server concurrent connections.
#   ## Useful in case of large number of topics or consumer groups.
#   # concurrent_connections = 20
#
#   ## Filter clusters, default is no filtering.
#   ## Values can be specified as glob patterns.
#   # clusters_include = []
#   # clusters_exclude = []
#
#   ## Filter consumer groups, default is no filtering.
#   ## Values can be specified as glob patterns.
#   # groups_include = []
#   # groups_exclude = []
#
#   ## Filter topics, default is no filtering.
#   ## Values can be specified as glob patterns.
#   # topics_include = []
#   # topics_exclude = []
#
#   ## Credentials for basic HTTP authentication.
#   # username = ""
#   # password = ""
#
#   ## Optional SSL config
#   # ssl_ca = "/etc/telegraf/ca.pem"
#   # ssl_cert = "/etc/telegraf/cert.pem"
#   # ssl_key = "/etc/telegraf/key.pem"
#   # insecure_skip_verify = false


# # Collects performance metrics from the MON, OSD, MDS and RGW nodes in a Ceph storage cluster.
# [[inputs.ceph]]
#   ## This is the recommended interval to poll.  Too frequent and you will lose
#   ## data points due to timeouts during rebalancing and recovery
#   interval = '1m'
#
#   ## All configuration values are optional, defaults are shown below
#
#   ## location of ceph binary
#   ceph_binary = "/usr/bin/ceph"
#
#   ## directory in which to look for socket files
#   socket_dir = "/var/run/ceph"
#
#   ## prefix of MON and OSD socket files, used to determine socket type
#   mon_prefix = "ceph-mon"
#   osd_prefix = "ceph-osd"
#   mds_prefix = "ceph-mds"
#   rgw_prefix = "ceph-client"
#
#   ## suffix used to identify socket files
#   socket_suffix = "asok"
#
#   ## Ceph user to authenticate as, ceph will search for the corresponding keyring
#   ## e.g. client.admin.keyring in /etc/ceph, or the explicit path defined in the
#   ## client section of ceph.conf for example:
#   ##
#   ##     [client.telegraf]
#   ##         keyring = /etc/ceph/client.telegraf.keyring
#   ##
#   ## Consult the ceph documentation for more detail on keyring generation.
#   ceph_user = "client.admin"
#
#   ## Ceph configuration to use to locate the cluster
#   ceph_config = "/etc/ceph/ceph.conf"
#
#   ## Whether to gather statistics via the admin socket
#   gather_admin_socket_stats = true
#
#   ## Whether to gather statistics via ceph commands, requires ceph_user and ceph_config
#   ## to be specified
#   gather_cluster_stats = false


# # Read specific statistics per cgroup
# [[inputs.cgroup]]
#   ## Directories in which to look for files, globs are supported.
#   ## Consider restricting paths to the set of cgroups you really
#   ## want to monitor if you have a large number of cgroups, to avoid
#   ## any cardinality issues.
#   # paths = [
#   #   "/sys/fs/cgroup/memory",
#   #   "/sys/fs/cgroup/memory/child1",
#   #   "/sys/fs/cgroup/memory/child2/*",
#   # ]
#   ## cgroup stat fields, as file names, globs are supported.
#   ## these file names are appended to each path from above.
#   # files = ["memory.*usage*", "memory.limit_in_bytes"]


# # Get standard chrony metrics, requires chronyc executable.
# [[inputs.chrony]]
#   ## If true, chronyc tries to perform a DNS lookup for the time server.
#   # dns_lookup = false


# # Pull Metric Statistics from Amazon CloudWatch
# [[inputs.cloudwatch]]
#   ## Amazon Region
#   region = "us-east-1"
#
#   ## Amazon Credentials
#   ## Credentials are loaded in the following order
#   ## 1) Web identity provider credentials via STS if role_arn and web_identity_token_file are specified
#   ## 2) Assumed credentials via STS if role_arn is specified
#   ## 3) explicit credentials from 'access_key' and 'secret_key'
#   ## 4) shared profile from 'profile'
#   ## 5) environment variables
#   ## 6) shared credentials file
#   ## 7) EC2 Instance Profile
#   # access_key = ""
#   # secret_key = ""
#   # token = ""
#   # role_arn = ""
#   # web_identity_token_file = ""
#   # role_session_name = ""
#   # profile = ""
#   # shared_credential_file = ""
#
#   ## Endpoint to make request against, the correct endpoint is automatically
#   ## determined and this option should only be set if you wish to override the
#   ## default.
#   ##   ex: endpoint_url = "http://localhost:8000"
#   # endpoint_url = ""
#
#   ## Set http_proxy (telegraf uses the system wide proxy settings if it's is not set)
#   # http_proxy_url = "http://localhost:8888"
#
#   # The minimum period for Cloudwatch metrics is 1 minute (60s). However not all
#   # metrics are made available to the 1 minute period. Some are collected at
#   # 3 minute, 5 minute, or larger intervals. See https://aws.amazon.com/cloudwatch/faqs/#monitoring.
#   # Note that if a period is configured that is smaller than the minimum for a
#   # particular metric, that metric will not be returned by the Cloudwatch API
#   # and will not be collected by Telegraf.
#   #
#   ## Requested CloudWatch aggregation Period (required - must be a multiple of 60s)
#   period = "5m"
#
#   ## Collection Delay (required - must account for metrics availability via CloudWatch API)
#   delay = "5m"
#
#   ## Recommended: use metric 'interval' that is a multiple of 'period' to avoid
#   ## gaps or overlap in pulled data
#   interval = "5m"
#
#   ## Recommended if "delay" and "period" are both within 3 hours of request time. Invalid values will be ignored.
#   ## Recently Active feature will only poll for CloudWatch ListMetrics values that occurred within the last 3 Hours.
#   ## If enabled, it will reduce total API usage of the CloudWatch ListMetrics API and require less memory to retain.
#   ## Do not enable if "period" or "delay" is longer than 3 hours, as it will not return data more than 3 hours old.
#   ## See https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_ListMetrics.html
#   #recently_active = "PT3H"
#
#   ## Configure the TTL for the internal cache of metrics.
#   # cache_ttl = "1h"
#
#   ## Metric Statistic Namespaces (required)
#   namespaces = ["AWS/ELB"]
#   # A single metric statistic namespace that will be appended to namespaces on startup
#   # namespace = "AWS/ELB"
#
#   ## Maximum requests per second. Note that the global default AWS rate limit is
#   ## 50 reqs/sec, so if you define multiple namespaces, these should add up to a
#   ## maximum of 50.
#   ## See http://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_limits.html
#   # ratelimit = 25
#
#   ## Timeout for http requests made by the cloudwatch client.
#   # timeout = "5s"
#
#   ## Namespace-wide statistic filters. These allow fewer queries to be made to
#   ## cloudwatch.
#   # statistic_include = [ "average", "sum", "minimum", "maximum", sample_count" ]
#   # statistic_exclude = []
#
#   ## Metrics to Pull
#   ## Defaults to all Metrics in Namespace if nothing is provided
#   ## Refreshes Namespace available metrics every 1h
#   #[[inputs.cloudwatch.metrics]]
#   #  names = ["Latency", "RequestCount"]
#   #
#   #  ## Statistic filters for Metric.  These allow for retrieving specific
#   #  ## statistics for an individual metric.
#   #  # statistic_include = [ "average", "sum", "minimum", "maximum", sample_count" ]
#   #  # statistic_exclude = []
#   #
#   #  ## Dimension filters for Metric.  All dimensions defined for the metric names
#   #  ## must be specified in order to retrieve the metric statistics.
#   #  ## 'value' has wildcard / 'glob' matching support such as 'p-*'.
#   #  [[inputs.cloudwatch.metrics.dimensions]]
#   #    name = "LoadBalancerName"
#   #    value = "p-example"


# # Collects conntrack stats from the configured directories and files.
# [[inputs.conntrack]]
#    ## The following defaults would work with multiple versions of conntrack.
#    ## Note the nf_ and ip_ filename prefixes are mutually exclusive across
#    ## kernel versions, as are the directory locations.
#
#    ## Superset of filenames to look for within the conntrack dirs.
#    ## Missing files will be ignored.
#    files = ["ip_conntrack_count","ip_conntrack_max",
#             "nf_conntrack_count","nf_conntrack_max"]
#
#    ## Directories to search within for the conntrack files above.
#    ## Missing directories will be ignored.
#    dirs = ["/proc/sys/net/ipv4/netfilter","/proc/sys/net/netfilter"]


# # Gather health check statuses from services registered in Consul
# [[inputs.consul]]
#   ## Consul server address
#   # address = "localhost:8500"
#
#   ## URI scheme for the Consul server, one of "http", "https"
#   # scheme = "http"
#
#   ## Metric version controls the mapping from Consul metrics into
#   ## Telegraf metrics.
#   ##
#   ##   example: metric_version = 1; deprecated in 1.15
#   ##            metric_version = 2; recommended version
#   # metric_version = 1
#
#   ## ACL token used in every request
#   # token = ""
#
#   ## HTTP Basic Authentication username and password.
#   # username = ""
#   # password = ""
#
#   ## Data center to query the health checks from
#   # datacenter = ""
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = true
#
#   ## Consul checks' tag splitting
#   # When tags are formatted like "key:value" with ":" as a delimiter then
#   # they will be splitted and reported as proper key:value in Telegraf
#   # tag_delimiter = ":"


# # Read metrics from the Consul API
# [[inputs.consul_metrics]]
#   ## URL for the Consul agent
#   # url = "http://127.0.0.1:8500"
#
#   ## Use auth token for authorization.
#   ## Only one of the options can be set. Leave empty to not use any token.
#   # token_file = "/path/to/auth/token"
#   ## OR
#   # token = "a1234567-40c7-9048-7bae-378687048181"
#
#   ## Set timeout (default 5 seconds)
#   # timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = /path/to/cafile
#   # tls_cert = /path/to/certfile
#   # tls_key = /path/to/keyfile


# # Read per-node and per-bucket metrics from Couchbase
# [[inputs.couchbase]]
#   ## specify servers via a url matching:
#   ##  [protocol://][:password]@address[:port]
#   ##  e.g.
#   ##    http://couchbase-0.example.com/
#   ##    http://admin:secret@couchbase-0.example.com:8091/
#   ##
#   ## If no servers are specified, then localhost is used as the host.
#   ## If no protocol is specified, HTTP is used.
#   ## If no port is specified, 8091 is used.
#   servers = ["http://localhost:8091"]
#
#   ## Filter bucket fields to include only here.
#   # bucket_stats_included = ["quota_percent_used", "ops_per_sec", "disk_fetches", "item_count", "disk_used", "data_used", "mem_used"]
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification (defaults to false)
#   ## If set to false, tls_cert and tls_key are required
#   # insecure_skip_verify = false


# # Read CouchDB Stats from one or more servers
# [[inputs.couchdb]]
#   ## Works with CouchDB stats endpoints out of the box
#   ## Multiple Hosts from which to read CouchDB stats:
#   hosts = ["http://localhost:8086/_stats"]
#
#   ## Use HTTP Basic Authentication.
#   # basic_username = "telegraf"
#   # basic_password = "p@ssw0rd"


# # Fetch metrics from a CSGO SRCDS
# [[inputs.csgo]]
#   ## Specify servers using the following format:
#   ##    servers = [
#   ##      ["ip1:port1", "rcon_password1"],
#   ##      ["ip2:port2", "rcon_password2"],
#   ##    ]
#   #
#   ## If no servers are specified, no data will be collected
#   servers = []


# # Input plugin for DC/OS metrics
# [[inputs.dcos]]
#   ## The DC/OS cluster URL.
#   cluster_url = "https://dcos-ee-master-1"
#
#   ## The ID of the service account.
#   service_account_id = "telegraf"
#   ## The private key file for the service account.
#   service_account_private_key = "/etc/telegraf/telegraf-sa-key.pem"
#
#   ## Path containing login token.  If set, will read on every gather.
#   # token_file = "/home/dcos/.dcos/token"
#
#   ## In all filter options if both include and exclude are empty all items
#   ## will be collected.  Arrays may contain glob patterns.
#   ##
#   ## Node IDs to collect metrics from.  If a node is excluded, no metrics will
#   ## be collected for its containers or apps.
#   # node_include = []
#   # node_exclude = []
#   ## Container IDs to collect container metrics from.
#   # container_include = []
#   # container_exclude = []
#   ## Container IDs to collect app metrics from.
#   # app_include = []
#   # app_exclude = []
#
#   ## Maximum concurrent connections to the cluster.
#   # max_connections = 10
#   ## Maximum time to receive a response from cluster.
#   # response_timeout = "20s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## If false, skip chain & host verification
#   # insecure_skip_verify = true
#
#   ## Recommended filtering to reduce series cardinality.
#   # [inputs.dcos.tagdrop]
#   #   path = ["/var/lib/mesos/slave/slaves/*"]


# # Read metrics from one or many disque servers
# [[inputs.disque]]
#   ## An array of URI to gather stats about. Specify an ip or hostname
#   ## with optional port and password.
#   ## ie disque://localhost, disque://10.10.3.33:18832, 10.0.0.1:10000, etc.
#   ## If no servers are specified, then localhost is used as the host.
#   servers = ["localhost"]


# # Provide a native collection for dmsetup based statistics for dm-cache
# [[inputs.dmcache]]
#   ## Whether to report per-device stats or not
#   per_device = true


# # Query given DNS server and gives statistics
# [[inputs.dns_query]]
#   ## servers to query
#   servers = ["8.8.8.8"]
#
#   ## Network is the network protocol name.
#   # network = "udp"
#
#   ## Domains or subdomains to query.
#   # domains = ["."]
#
#   ## Query record type.
#   ## Possible values: A, AAAA, CNAME, MX, NS, PTR, TXT, SOA, SPF, SRV.
#   # record_type = "A"
#
#   ## Dns server port.
#   # port = 53
#
#   ## Query timeout in seconds.
#   # timeout = 2


# # Read metrics about docker containers
 [[inputs.docker]]
#   ## Docker Endpoint
#   ##   To use TCP, set endpoint = "tcp://[ip]:[port]"
#   ##   To use environment variables (ie, docker-machine), set endpoint = "ENV"
   endpoint = "unix:///var/run/docker.sock"
#
#   ## Set to true to collect Swarm metrics(desired_replicas, running_replicas)
#   gather_services = false
#
#   ## Set the source tag for the metrics to the container ID hostname, eg first 12 chars
#   source_tag = false
#
#   ## Containers to include and exclude. Globs accepted.
#   ## Note that an empty array for both will include all containers
#   container_name_include = []
#   container_name_exclude = []
#
#   ## Container states to include and exclude. Globs accepted.
#   ## When empty only containers in the "running" state will be captured.
#   ## example: container_state_include = ["created", "restarting", "running", "removing", "paused", "exited", "dead"]
#   ## example: container_state_exclude = ["created", "restarting", "running", "removing", "paused", "exited", "dead"]
   container_state_include = ["created", "restarting", "running", "removing", "paused", "exited", "dead"]
#   # container_state_exclude = []
#
#   ## Timeout for docker list, info, and stats commands
   timeout = "10s"
#
#   ## Specifies for which classes a per-device metric should be issued
#   ## Possible values are 'cpu' (cpu0, cpu1, ...), 'blkio' (8:0, 8:1, ...) and 'network' (eth0, eth1, ...)
#   ## Please note that this setting has no effect if 'perdevice' is set to 'true'
#   # perdevice_include = ["cpu"]
#
#   ## Specifies for which classes a total metric should be issued. Total is an aggregated of the 'perdevice' values.
#   ## Possible values are 'cpu', 'blkio' and 'network'
#   ## Total 'cpu' is reported directly by Docker daemon, and 'network' and 'blkio' totals are aggregated by this plugin.
#   ## Please note that this setting has no effect if 'total' is set to 'false'
#   # total_include = ["cpu", "blkio", "network"]
#
#   ## Which environment variables should we use as a tag
#   ##tag_env = ["JAVA_HOME", "HEAP_SIZE"]
#
#   ## docker labels to include and exclude as tags.  Globs accepted.
#   ## Note that an empty array for both will include all labels as tags
#   docker_label_include = []
#   docker_label_exclude = []
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Read statistics from one or many dovecot servers
# [[inputs.dovecot]]
#   ## specify dovecot servers via an address:port list
#   ##  e.g.
#   ##    localhost:24242
#   ##
#   ## If no servers are specified, then localhost is used as the host.
#   servers = ["localhost:24242"]
#
#   ## Type is one of "user", "domain", "ip", or "global"
#   type = "global"
#
#   ## Wildcard matches like "*.com". An empty string "" is same as "*"
#   ## If type = "ip" filters should be <IP/network>
#   filters = [""]


# # Reads metrics from DPDK applications using v2 telemetry interface.
# [[inputs.dpdk]]
#   ## Path to DPDK telemetry socket. This shall point to v2 version of DPDK telemetry interface.
#   # socket_path = "/var/run/dpdk/rte/dpdk_telemetry.v2"
#
#   ## Duration that defines how long the connected socket client will wait for a response before terminating connection.
#   ## This includes both writing to and reading from socket. Since it's local socket access
#   ## to a fast packet processing application, the timeout should be sufficient for most users.
#   ## Setting the value to 0 disables the timeout (not recommended)
#   # socket_access_timeout = "200ms"
#
#   ## Enables telemetry data collection for selected device types.
#   ## Adding "ethdev" enables collection of telemetry from DPDK NICs (stats, xstats, link_status).
#   ## Adding "rawdev" enables collection of telemetry from DPDK Raw Devices (xstats).
#   # device_types = ["ethdev"]
#
#   ## List of custom, application-specific telemetry commands to query
#   ## The list of available commands depend on the application deployed. Applications can register their own commands
#   ##   via telemetry library API http://doc.dpdk.org/guides/prog_guide/telemetry_lib.html#registering-commands
#   ## For e.g. L3 Forwarding with Power Management Sample Application this could be:
#   ##   additional_commands = ["/l3fwd-power/stats"]
#   # additional_commands = []
#
#   ## Allows turning off collecting data for individual "ethdev" commands.
#   ## Remove "/ethdev/link_status" from list to start getting link status metrics.
#   [inputs.dpdk.ethdev]
#     exclude_commands = ["/ethdev/link_status"]
#
#   ## When running multiple instances of the plugin it's recommended to add a unique tag to each instance to identify
#   ## metrics exposed by an instance of DPDK application. This is useful when multiple DPDK apps run on a single host.
#   ##  [inputs.dpdk.tags]
#   ##    dpdk_instance = "my-fwd-app"


# # Read metrics about docker containers from Fargate/ECS v2, v3 meta endpoints.
# [[inputs.ecs]]
#   ## ECS metadata url.
#   ## Metadata v2 API is used if set explicitly. Otherwise,
#   ## v3 metadata endpoint API is used if available.
#   # endpoint_url = ""
#
#   ## Containers to include and exclude. Globs accepted.
#   ## Note that an empty array for both will include all containers
#   # container_name_include = []
#   # container_name_exclude = []
#
#   ## Container states to include and exclude. Globs accepted.
#   ## When empty only containers in the "RUNNING" state will be captured.
#   ## Possible values are "NONE", "PULLED", "CREATED", "RUNNING",
#   ## "RESOURCES_PROVISIONED", "STOPPED".
#   # container_status_include = []
#   # container_status_exclude = []
#
#   ## ecs labels to include and exclude as tags.  Globs accepted.
#   ## Note that an empty array for both will include all labels as tags
#   ecs_label_include = [ "com.amazonaws.ecs.*" ]
#   ecs_label_exclude = []
#
#   ## Timeout for queries.
#   # timeout = "5s"


# # Read stats from one or more Elasticsearch servers or clusters
# [[inputs.elasticsearch]]
#   ## specify a list of one or more Elasticsearch servers
#   # you can add username and password to your url to use basic authentication:
#   # servers = ["http://user:pass@localhost:9200"]
#   servers = ["http://localhost:9200"]
#
#   ## Timeout for HTTP requests to the elastic search server(s)
#   http_timeout = "5s"
#
#   ## When local is true (the default), the node will read only its own stats.
#   ## Set local to false when you want to read the node stats from all nodes
#   ## of the cluster.
#   local = true
#
#   ## Set cluster_health to true when you want to also obtain cluster health stats
#   cluster_health = false
#
#   ## Adjust cluster_health_level when you want to also obtain detailed health stats
#   ## The options are
#   ##  - indices (default)
#   ##  - cluster
#   # cluster_health_level = "indices"
#
#   ## Set cluster_stats to true when you want to also obtain cluster stats.
#   cluster_stats = false
#
#   ## Only gather cluster_stats from the master node. To work this require local = true
#   cluster_stats_only_from_master = true
#
#   ## Indices to collect; can be one or more indices names or _all
#   ## Use of wildcards is allowed. Use a wildcard at the end to retrieve index names that end with a changing value, like a date.
#   indices_include = ["_all"]
#
#   ## One of "shards", "cluster", "indices"
#   indices_level = "shards"
#
#   ## node_stats is a list of sub-stats that you want to have gathered. Valid options
#   ## are "indices", "os", "process", "jvm", "thread_pool", "fs", "transport", "http",
#   ## "breaker". Per default, all stats are gathered.
#   # node_stats = ["jvm", "http"]
#
#   ## HTTP Basic Authentication username and password.
#   # username = ""
#   # password = ""
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## Sets the number of most recent indices to return for indices that are configured with a date-stamped suffix.
#   ## Each 'indices_include' entry ending with a wildcard (*) or glob matching pattern will group together all indices that match it, and sort them
#   ## by the date or number after the wildcard. Metrics then are gathered for only the 'num_most_recent_indices' amount of most recent indices.
#   # num_most_recent_indices = 0


# # Derive metrics from aggregating Elasticsearch query results
# [[inputs.elasticsearch_query]]
#   ## The full HTTP endpoint URL for your Elasticsearch instance
#   ## Multiple urls can be specified as part of the same cluster,
#   ## this means that only ONE of the urls will be written to each interval.
#   urls = [ "http://node1.es.example.com:9200" ] # required.
#
#   ## Elasticsearch client timeout, defaults to "5s".
#   # timeout = "5s"
#
#   ## Set to true to ask Elasticsearch a list of all cluster nodes,
#   ## thus it is not necessary to list all nodes in the urls config option
#   # enable_sniffer = false
#
#   ## Set the interval to check if the Elasticsearch nodes are available
#   ## This option is only used if enable_sniffer is also set (0s to disable it)
#   # health_check_interval = "10s"
#
#   ## HTTP basic authentication details (eg. when using x-pack)
#   # username = "telegraf"
#   # password = "mypassword"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   [[inputs.elasticsearch_query.aggregation]]
#     ## measurement name for the results of the aggregation query
#     measurement_name = "measurement"
#
#     ## Elasticsearch indexes to query (accept wildcards).
#     index = "index-*"
#
#     ## The date/time field in the Elasticsearch index (mandatory).
#     date_field = "@timestamp"
#
#     ## If the field used for the date/time field in Elasticsearch is also using
#     ## a custom date/time format it may be required to provide the format to
#     ## correctly parse the field.
#     ##
#     ## If using one of the built in elasticsearch formats this is not required.
#     # date_field_custom_format = ""
#
#     ## Time window to query (eg. "1m" to query documents from last minute).
#     ## Normally should be set to same as collection interval
#     query_period = "1m"
#
#     ## Lucene query to filter results
#     # filter_query = "*"
#
#     ## Fields to aggregate values (must be numeric fields)
#     # metric_fields = ["metric"]
#
#     ## Aggregation function to use on the metric fields
#     ## Must be set if 'metric_fields' is set
#     ## Valid values are: avg, sum, min, max, sum
#     # metric_function = "avg"
#
#     ## Fields to be used as tags
#     ## Must be text, non-analyzed fields. Metric aggregations are performed per tag
#     # tags = ["field.keyword", "field2.keyword"]
#
#     ## Set to true to not ignore documents when the tag(s) above are missing
#     # include_missing_tag = false
#
#     ## String value of the tag when the tag does not exist
#     ## Used when include_missing_tag is true
#     # missing_tag_value = "null"


# # Returns ethtool statistics for given interfaces
# [[inputs.ethtool]]
#   ## List of interfaces to pull metrics for
#   # interface_include = ["eth0"]
#
#   ## List of interfaces to ignore when pulling metrics.
#   # interface_exclude = ["eth1"]
#
#   ## Some drivers declare statistics with extra whitespace, different spacing,
#   ## and mix cases. This list, when enabled, can be used to clean the keys.
#   ## Here are the current possible normalizations:
#   ##  * snakecase: converts fooBarBaz to foo_bar_baz
#   ##  * trim: removes leading and trailing whitespace
#   ##  * lower: changes all capitalized letters to lowercase
#   ##  * underscore: replaces spaces with underscores
#   # normalize_keys = ["snakecase", "trim", "lower", "underscore"]


# # Read metrics from one or more commands that can output to stdout
# [[inputs.exec]]
#   ## Commands array
#   commands = [
#     "/tmp/test.sh",
#     "/usr/bin/mycollector --foo=bar",
#     "/tmp/collect_*.sh"
#   ]
#
#   ## Timeout for each command to complete.
#   timeout = "5s"
#
#   ## measurement name suffix (for separating different commands)
#   name_suffix = "_mycollector"
#
#   ## Data format to consume.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   data_format = "influx"


# # Read metrics from fail2ban.
# [[inputs.fail2ban]]
#   ## Use sudo to run fail2ban-client
#   use_sudo = false


# # Read devices value(s) from a Fibaro controller
# [[inputs.fibaro]]
#   ## Required Fibaro controller address/hostname.
#   ## Note: at the time of writing this plugin, Fibaro only implemented http - no https available
#   url = "http://<controller>:80"
#
#   ## Required credentials to access the API (http://<controller/api/<component>)
#   username = "<username>"
#   password = "<password>"
#
#   ## Amount of time allowed to complete the HTTP request
#   # timeout = "5s"


# # Parse a complete file each interval
# [[inputs.file]]
#   ## Files to parse each interval.  Accept standard unix glob matching rules,
#   ## as well as ** to match recursive files and directories.
#   files = ["/tmp/metrics.out"]
#
#
#   ## Name a tag containing the name of the file the data was parsed from.  Leave empty
#   ## to disable. Cautious when file name variation is high, this can increase the cardinality
#   ## significantly. Read more about cardinality here:
#   ## https://docs.influxdata.com/influxdb/cloud/reference/glossary/#series-cardinality
#   # file_tag = ""
#   #
#
#   ## Character encoding to use when interpreting the file contents.  Invalid
#   ## characters are replaced using the unicode replacement character.  When set
#   ## to the empty string the data is not decoded to text.
#   ##   ex: character_encoding = "utf-8"
#   ##       character_encoding = "utf-16le"
#   ##       character_encoding = "utf-16be"
#   ##       character_encoding = ""
#   # character_encoding = ""
#
#   ## The dataformat to be read from files
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   data_format = "influx"


# # Count files in a directory
# [[inputs.filecount]]
#   ## Directories to gather stats about.
#   ## This accept standard unit glob matching rules, but with the addition of
#   ## ** as a "super asterisk". ie:
#   ##   /var/log/**    -> recursively find all directories in /var/log and count files in each directories
#   ##   /var/log/*/*   -> find all directories with a parent dir in /var/log and count files in each directories
#   ##   /var/log       -> count all files in /var/log and all of its subdirectories
#   directories = ["/var/cache/apt/archives"]
#
#   ## Only count files that match the name pattern. Defaults to "*".
#   name = "*.deb"
#
#   ## Count files in subdirectories. Defaults to true.
#   recursive = false
#
#   ## Only count regular files. Defaults to true.
#   regular_only = true
#
#   ## Follow all symlinks while walking the directory tree. Defaults to false.
#   follow_symlinks = false
#
#   ## Only count files that are at least this size. If size is
#   ## a negative number, only count files that are smaller than the
#   ## absolute value of size. Acceptable units are B, KiB, MiB, KB, ...
#   ## Without quotes and units, interpreted as size in bytes.
#   size = "0B"
#
#   ## Only count files that have not been touched for at least this
#   ## duration. If mtime is negative, only count files that have been
#   ## touched in this duration. Defaults to "0s".
#   mtime = "0s"


# # Read stats about given file(s)
# [[inputs.filestat]]
#   ## Files to gather stats about.
#   ## These accept standard unix glob matching rules, but with the addition of
#   ## ** as a "super asterisk". ie:
#   ##   "/var/log/**.log"  -> recursively find all .log files in /var/log
#   ##   "/var/log/*/*.log" -> find all .log files with a parent dir in /var/log
#   ##   "/var/log/apache.log" -> just tail the apache log file
#   ##
#   ## See https://github.com/gobwas/glob for more examples
#   ##
#   files = ["/var/log/**.log"]
#
#   ## If true, read the entire file and calculate an md5 checksum.
#   md5 = false


# # Read real time temps from fireboard.io servers
# [[inputs.fireboard]]
#   ## Specify auth token for your account
#   auth_token = "invalidAuthToken"
#   ## You can override the fireboard server URL if necessary
#   # url = https://fireboard.io/api/v1/devices.json
#   ## You can set a different http_timeout if you need to
#   ## You should set a string using an number and time indicator
#   ## for example "12s" for 12 seconds.
#   # http_timeout = "4s"


# # Read metrics exposed by fluentd in_monitor plugin
# [[inputs.fluentd]]
#   ## This plugin reads information exposed by fluentd (using /api/plugins.json endpoint).
#   ##
#   ## Endpoint:
#   ## - only one URI is allowed
#   ## - https is not supported
#   endpoint = "http://localhost:24220/api/plugins.json"
#
#   ## Define which plugins have to be excluded (based on "type" field - e.g. monitor_agent)
#   exclude = [
# 	  "monitor_agent",
# 	  "dummy",
#   ]


# # Gather repository information from GitHub hosted repositories.
# [[inputs.github]]
#   ## List of repositories to monitor.
#   repositories = [
# 	  "influxdata/telegraf",
# 	  "influxdata/influxdb"
#   ]
#
#   ## Github API access token.  Unauthenticated requests are limited to 60 per hour.
#   # access_token = ""
#
#   ## Github API enterprise url. Github Enterprise accounts must specify their base url.
#   # enterprise_base_url = ""
#
#   ## Timeout for HTTP requests.
#   # http_timeout = "5s"
#
#   ## List of additional fields to query.
# 	## NOTE: Getting those fields might involve issuing additional API-calls, so please
# 	##       make sure you do not exceed the rate-limit of GitHub.
# 	##
# 	## Available fields are:
# 	## 	- pull-requests			-- number of open and closed pull requests (2 API-calls per repository)
#   # additional_fields = []


# # Read flattened metrics from one or more GrayLog HTTP endpoints
# [[inputs.graylog]]
#   ## API endpoint, currently supported API:
#   ##
#   ##   - multiple  (e.g. http://<host>:9000/api/system/metrics/multiple)
#   ##   - namespace (e.g. http://<host>:9000/api/system/metrics/namespace/{namespace})
#   ##
#   ## For namespace endpoint, the metrics array will be ignored for that call.
#   ## Endpoint can contain namespace and multiple type calls.
#   ##
#   ## Please check http://[graylog-server-ip]:9000/api/api-browser for full list
#   ## of endpoints
#   servers = [
#     "http://[graylog-server-ip]:9000/api/system/metrics/multiple",
#   ]
#
#   ## Set timeout (default 5 seconds)
#   # timeout = "5s"
#
#   ## Metrics list
#   ## List of metrics can be found on Graylog webservice documentation.
#   ## Or by hitting the web service api at:
#   ##   http://[graylog-host]:9000/api/system/metrics
#   metrics = [
#     "jvm.cl.loaded",
#     "jvm.memory.pools.Metaspace.committed"
#   ]
#
#   ## Username and password
#   username = ""
#   password = ""
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Read metrics of haproxy, via socket or csv stats page
# [[inputs.haproxy]]
#   ## An array of address to gather stats about. Specify an ip on hostname
#   ## with optional port. ie localhost, 10.10.3.33:1936, etc.
#   ## Make sure you specify the complete path to the stats endpoint
#   ## including the protocol, ie http://10.10.3.33:1936/haproxy?stats
#
#   ## If no servers are specified, then default to 127.0.0.1:1936/haproxy?stats
#   servers = ["http://myhaproxy.com:1936/haproxy?stats"]
#
#   ## Credentials for basic HTTP authentication
#   # username = "admin"
#   # password = "admin"
#
#   ## You can also use local socket with standard wildcard globbing.
#   ## Server address not starting with 'http' will be treated as a possible
#   ## socket, so both examples below are valid.
#   # servers = ["socket:/run/haproxy/admin.sock", "/run/haproxy/*.sock"]
#
#   ## By default, some of the fields are renamed from what haproxy calls them.
#   ## Setting this option to true results in the plugin keeping the original
#   ## field names.
#   # keep_field_names = false
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Monitor disks' temperatures using hddtemp
# [[inputs.hddtemp]]
#   ## By default, telegraf gathers temps data from all disks detected by the
#   ## hddtemp.
#   ##
#   ## Only collect temps from the selected disks.
#   ##
#   ## A * as the device name will return the temperature values of all disks.
#   ##
#   # address = "127.0.0.1:7634"
#   # devices = ["sda", "*"]


# # Read formatted metrics from one or more HTTP endpoints
# [[inputs.http]]
#   ## One or more URLs from which to read formatted metrics
#   urls = [
#     "http://localhost/metrics"
#   ]
#
#   ## HTTP method
#   # method = "GET"
#
#   ## Optional HTTP headers
#   # headers = {"X-Special-Header" = "Special-Value"}
#
#   ## Optional file with Bearer token
#   ## file content is added as an Authorization header
#   # bearer_token = "/path/to/file"
#
#   ## Optional HTTP Basic Auth Credentials
#   # username = "username"
#   # password = "pa$$word"
#
#   ## HTTP entity-body to send with POST/PUT requests.
#   # body = ""
#
#   ## HTTP Content-Encoding for write request body, can be set to "gzip" to
#   ## compress body or "identity" to apply no encoding.
#   # content_encoding = "identity"
#
#   ## HTTP Proxy support
#   # http_proxy_url = ""
#
#   ## OAuth2 Client Credentials Grant
#   # client_id = "clientid"
#   # client_secret = "secret"
#   # token_url = "https://indentityprovider/oauth2/v1/token"
#   # scopes = ["urn:opc:idm:__myscopes__"]
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## Optional Cookie authentication
#   # cookie_auth_url = "https://localhost/authMe"
#   # cookie_auth_method = "POST"
#   # cookie_auth_username = "username"
#   # cookie_auth_password = "pa$$word"
#   # cookie_auth_headers = '{"Content-Type": "application/json", "X-MY-HEADER":"hello"}'
#   # cookie_auth_body = '{"username": "user", "password": "pa$$word", "authenticate": "me"}'
#   ## cookie_auth_renewal not set or set to "0" will auth once and never renew the cookie
#   # cookie_auth_renewal = "5m"
#
#   ## Amount of time allowed to complete the HTTP request
#   # timeout = "5s"
#
#   ## List of success status codes
#   # success_status_codes = [200]
#
#   ## Data format to consume.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   # data_format = "influx"


# # HTTP/HTTPS request given an address a method and a timeout
# [[inputs.http_response]]
#   ## List of urls to query.
#   # urls = ["http://localhost"]
#
#   ## Set http_proxy (telegraf uses the system wide proxy settings if it's is not set)
#   # http_proxy = "http://localhost:8888"
#
#   ## Set response_timeout (default 5 seconds)
#   # response_timeout = "5s"
#
#   ## HTTP Request Method
#   # method = "GET"
#
#   ## Whether to follow redirects from the server (defaults to false)
#   # follow_redirects = false
#
#   ## Optional file with Bearer token
#   ## file content is added as an Authorization header
#   # bearer_token = "/path/to/file"
#
#   ## Optional HTTP Basic Auth Credentials
#   # username = "username"
#   # password = "pa$$word"
#
#   ## Optional HTTP Request Body
#   # body = '''
#   # {'fake':'data'}
#   # '''
#
#   ## Optional name of the field that will contain the body of the response.
#   ## By default it is set to an empty String indicating that the body's content won't be added
#   # response_body_field = ''
#
#   ## Maximum allowed HTTP response body size in bytes.
#   ## 0 means to use the default of 32MiB.
#   ## If the response body size exceeds this limit a "body_read_error" will be raised
#   # response_body_max_size = "32MiB"
#
#   ## Optional substring or regex match in body of the response (case sensitive)
#   # response_string_match = "\"service_status\": \"up\""
#   # response_string_match = "ok"
#   # response_string_match = "\".*_status\".?:.?\"up\""
#
#   ## Expected response status code.
#   ## The status code of the response is compared to this value. If they match, the field
#   ## "response_status_code_match" will be 1, otherwise it will be 0. If the
#   ## expected status code is 0, the check is disabled and the field won't be added.
#   # response_status_code = 0
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## HTTP Request Headers (all values must be strings)
#   # [inputs.http_response.headers]
#   #   Host = "github.com"
#
#   ## Optional setting to map response http headers into tags
#   ## If the http header is not present on the request, no corresponding tag will be added
#   ## If multiple instances of the http header are present, only the first value will be used
#   # http_header_tags = {"HTTP_HEADER" = "TAG_NAME"}
#
#   ## Interface to use when dialing an address
#   # interface = "eth0"


# # Read flattened metrics from one or more JSON HTTP endpoints
# [[inputs.httpjson]]
#   ## DEPRECATED: The 'httpjson' plugin is deprecated in version 1.6.0, use 'inputs.http' instead.
#   ## NOTE This plugin only reads numerical measurements, strings and booleans
#   ## will be ignored.
#
#   ## URL of each server in the service's cluster
#   servers = [
#     "http://localhost:9999/stats/",
#     "http://localhost:9998/stats/",
#   ]
#   ## Set response_timeout (default 5 seconds)
#   response_timeout = "5s"
#
#   ## HTTP method to use: GET or POST (case-sensitive)
#   method = "GET"
#
#   ## List of tag names to extract from top-level of JSON server response
#   # tag_keys = [
#   #   "my_tag_1",
#   #   "my_tag_2"
#   # ]
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## HTTP parameters (all values must be strings).  For "GET" requests, data
#   ## will be included in the query.  For "POST" requests, data will be included
#   ## in the request body as "x-www-form-urlencoded".
#   # [inputs.httpjson.parameters]
#   #   event_type = "cpu_spike"
#   #   threshold = "0.75"
#
#   ## HTTP Headers (all values must be strings)
#   # [inputs.httpjson.headers]
#   #   X-Auth-Token = "my-xauth-token"
#   #   apiVersion = "v1"


# # Gather Icinga2 status
# [[inputs.icinga2]]
#   ## Required Icinga2 server address
#   # server = "https://localhost:5665"
#
#   ## Required Icinga2 object type ("services" or "hosts")
#   # object_type = "services"
#
#   ## Credentials for basic HTTP authentication
#   # username = "admin"
#   # password = "admin"
#
#   ## Maximum time to receive response.
#   # response_timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = true


# # Gets counters from all InfiniBand cards and ports installed
# [[inputs.infiniband]]
#   # no configuration


# # Read InfluxDB-formatted JSON metrics from one or more HTTP endpoints
# [[inputs.influxdb]]
#   ## Works with InfluxDB debug endpoints out of the box,
#   ## but other services can use this format too.
#   ## See the influxdb plugin's README for more details.
#
#   ## Multiple URLs from which to read InfluxDB-formatted JSON
#   ## Default is "http://localhost:8086/debug/vars".
#   urls = [
#     "http://localhost:8086/debug/vars"
#   ]
#
#   ## Username and password to send using HTTP Basic Authentication.
#   # username = ""
#   # password = ""
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## http request & header timeout
#   timeout = "5s"


# # Intel PowerStat plugin enables monitoring of platform metrics (power, TDP) and Core metrics like temperature, power and utilization.
# [[inputs.intel_powerstat]]
#   ## All global metrics are always collected by Intel PowerStat plugin.
#   ## User can choose which per-CPU metrics are monitored by the plugin in cpu_metrics array.
#   ## Empty array means no per-CPU specific metrics will be collected by the plugin - in this case only platform level
#   ## telemetry will be exposed by Intel PowerStat plugin.
#   ## Supported options:
#   ## "cpu_frequency", "cpu_busy_frequency", "cpu_temperature", "cpu_c1_state_residency", "cpu_c6_state_residency", "cpu_busy_cycles"
#   # cpu_metrics = []


# # Collect statistics about itself
# [[inputs.internal]]
#   ## If true, collect telegraf memory stats.
#   # collect_memstats = true


# # Monitors internet speed using speedtest.net service
# [[inputs.internet_speed]]
#   ## Sets if runs file download test
#   # enable_file_download = false
#
#   ## Caches the closest server location
#   # cache = false


# # This plugin gathers interrupts data from /proc/interrupts and /proc/softirqs.
# [[inputs.interrupts]]
#   ## When set to true, cpu metrics are tagged with the cpu.  Otherwise cpu is
#   ## stored as a field.
#   ##
#   ## The default is false for backwards compatibility, and will be changed to
#   ## true in a future version.  It is recommended to set to true on new
#   ## deployments.
#   # cpu_as_tag = false
#
#   ## To filter which IRQs to collect, make use of tagpass / tagdrop, i.e.
#   # [inputs.interrupts.tagdrop]
#   #   irq = [ "NET_RX", "TASKLET" ]


# # Read metrics from the bare metal servers via IPMI
# [[inputs.ipmi_sensor]]
#   ## optionally specify the path to the ipmitool executable
#   # path = "/usr/bin/ipmitool"
#   ##
#   ## Setting 'use_sudo' to true will make use of sudo to run ipmitool.
#   ## Sudo must be configured to allow the telegraf user to run ipmitool
#   ## without a password.
#   # use_sudo = false
#   ##
#   ## optionally force session privilege level. Can be CALLBACK, USER, OPERATOR, ADMINISTRATOR
#   # privilege = "ADMINISTRATOR"
#   ##
#   ## optionally specify one or more servers via a url matching
#   ##  [username[:password]@][protocol[(address)]]
#   ##  e.g.
#   ##    root:passwd@lan(127.0.0.1)
#   ##
#   ## if no servers are specified, local machine sensor stats will be queried
#   ##
#   # servers = ["USERID:PASSW0RD@lan(192.168.1.1)"]
#
#   ## Recommended: use metric 'interval' that is a multiple of 'timeout' to avoid
#   ## gaps or overlap in pulled data
#   interval = "30s"
#
#   ## Timeout for the ipmitool command to complete
#   timeout = "20s"
#
#   ## Schema Version: (Optional, defaults to version 1)
#   metric_version = 2
#
#   ## Optionally provide the hex key for the IMPI connection.
#   # hex_key = ""
#
#   ## If ipmitool should use a cache
#   ## for me ipmitool runs about 2 to 10 times faster with cache enabled on HP G10 servers (when using ubuntu20.04)
#   ## the cache file may not work well for you if some sensors come up late
#   # use_cache = false
#
#   ## Path to the ipmitools cache file (defaults to OS temp dir)
#   ## The provided path must exist and must be writable
#   # cache_path = ""


# # Gather packets and bytes counters from Linux ipsets
# [[inputs.ipset]]
#   ## By default, we only show sets which have already matched at least 1 packet.
#   ## set include_unmatched_sets = true to gather them all.
#   include_unmatched_sets = false
#   ## Adjust your sudo settings appropriately if using this option ("sudo ipset save")
#   use_sudo = false
#   ## The default timeout of 1s for ipset execution can be overridden here:
#   # timeout = "1s"


# # Gather packets and bytes throughput from iptables
# [[inputs.iptables]]
#   ## iptables require root access on most systems.
#   ## Setting 'use_sudo' to true will make use of sudo to run iptables.
#   ## Users must configure sudo to allow telegraf user to run iptables with no password.
#   ## iptables can be restricted to only list command "iptables -nvL".
#   use_sudo = false
#   ## Setting 'use_lock' to true runs iptables with the "-w" option.
#   ## Adjust your sudo settings appropriately if using this option ("iptables -w 5 -nvl")
#   use_lock = false
#   ## Define an alternate executable, such as "ip6tables". Default is "iptables".
#   # binary = "ip6tables"
#   ## defines the table to monitor:
#   table = "filter"
#   ## defines the chains to monitor.
#   ## NOTE: iptables rules without a comment will not be monitored.
#   ## Read the plugin documentation for more information.
#   chains = [ "INPUT" ]


# # Collect virtual and real server stats from Linux IPVS
# [[inputs.ipvs]]
#   # no configuration


# # Read jobs and cluster metrics from Jenkins instances
# [[inputs.jenkins]]
#   ## The Jenkins URL in the format "schema://host:port"
#   url = "http://my-jenkins-instance:8080"
#   # username = "admin"
#   # password = "admin"
#
#   ## Set response_timeout
#   response_timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use SSL but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## Optional Max Job Build Age filter
#   ## Default 1 hour, ignore builds older than max_build_age
#   # max_build_age = "1h"
#
#   ## Optional Sub Job Depth filter
#   ## Jenkins can have unlimited layer of sub jobs
#   ## This config will limit the layers of pulling, default value 0 means
#   ## unlimited pulling until no more sub jobs
#   # max_subjob_depth = 0
#
#   ## Optional Sub Job Per Layer
#   ## In workflow-multibranch-plugin, each branch will be created as a sub job.
#   ## This config will limit to call only the lasted branches in each layer,
#   ## empty will use default value 10
#   # max_subjob_per_layer = 10
#
#   ## Jobs to include or exclude from gathering
#   ## When using both lists, job_exclude has priority.
#   ## Wildcards are supported: [ "jobA/*", "jobB/subjob1/*"]
#   # job_include = [ "*" ]
#   # job_exclude = [ ]
#
#   ## Nodes to include or exclude from gathering
#   ## When using both lists, node_exclude has priority.
#   # node_include = [ "*" ]
#   # node_exclude = [ ]
#
#   ## Worker pool for jenkins plugin only
#   ## Empty this field will use default value 5
#   # max_connections = 5


# # Read JMX metrics through Jolokia
# [[inputs.jolokia]]
#   ## DEPRECATED: The 'jolokia' plugin is deprecated in version 1.5.0, use 'inputs.jolokia2' instead.
#   # DEPRECATED: the jolokia plugin has been deprecated in favor of the
#   # jolokia2 plugin
#   # see https://github.com/influxdata/telegraf/tree/master/plugins/inputs/jolokia2
#
#   ## This is the context root used to compose the jolokia url
#   ## NOTE that Jolokia requires a trailing slash at the end of the context root
#   ## NOTE that your jolokia security policy must allow for POST requests.
#   context = "/jolokia/"
#
#   ## This specifies the mode used
#   # mode = "proxy"
#   #
#   ## When in proxy mode this section is used to specify further
#   ## proxy address configurations.
#   ## Remember to change host address to fit your environment.
#   # [inputs.jolokia.proxy]
#   #   host = "127.0.0.1"
#   #   port = "8080"
#
#   ## Optional http timeouts
#   ##
#   ## response_header_timeout, if non-zero, specifies the amount of time to wait
#   ## for a server's response headers after fully writing the request.
#   # response_header_timeout = "3s"
#   ##
#   ## client_timeout specifies a time limit for requests made by this client.
#   ## Includes connection time, any redirects, and reading the response body.
#   # client_timeout = "4s"
#
#   ## Attribute delimiter
#   ##
#   ## When multiple attributes are returned for a single
#   ## [inputs.jolokia.metrics], the field name is a concatenation of the metric
#   ## name, and the attribute name, separated by the given delimiter.
#   # delimiter = "_"
#
#   ## List of servers exposing jolokia read service
#   [[inputs.jolokia.servers]]
#     name = "as-server-01"
#     host = "127.0.0.1"
#     port = "8080"
#     # username = "myuser"
#     # password = "mypassword"
#
#   ## List of metrics collected on above servers
#   ## Each metric consists in a name, a jmx path and either
#   ## a pass or drop slice attribute.
#   ## This collect all heap memory usage metrics.
#   [[inputs.jolokia.metrics]]
#     name = "heap_memory_usage"
#     mbean  = "java.lang:type=Memory"
#     attribute = "HeapMemoryUsage"
#
#   ## This collect thread counts metrics.
#   [[inputs.jolokia.metrics]]
#     name = "thread_count"
#     mbean  = "java.lang:type=Threading"
#     attribute = "TotalStartedThreadCount,ThreadCount,DaemonThreadCount,PeakThreadCount"
#
#   ## This collect number of class loaded/unloaded counts metrics.
#   [[inputs.jolokia.metrics]]
#     name = "class_count"
#     mbean  = "java.lang:type=ClassLoading"
#     attribute = "LoadedClassCount,UnloadedClassCount,TotalLoadedClassCount"


# # Read JMX metrics from a Jolokia REST agent endpoint
# [[inputs.jolokia2_agent]]
#   # default_tag_prefix      = ""
#   # default_field_prefix    = ""
#   # default_field_separator = "."
#
#   # Add agents URLs to query
#   urls = ["http://localhost:8080/jolokia"]
#   # username = ""
#   # password = ""
#   # response_timeout = "5s"
#
#   ## Optional TLS config
#   # tls_ca   = "/var/private/ca.pem"
#   # tls_cert = "/var/private/client.pem"
#   # tls_key  = "/var/private/client-key.pem"
#   # insecure_skip_verify = false
#
#   ## Add metrics to read
#   [[inputs.jolokia2_agent.metric]]
#     name  = "java_runtime"
#     mbean = "java.lang:type=Runtime"
#     paths = ["Uptime"]


# # Read JMX metrics from a Jolokia REST proxy endpoint
# [[inputs.jolokia2_proxy]]
#   # default_tag_prefix      = ""
#   # default_field_prefix    = ""
#   # default_field_separator = "."
#
#   ## Proxy agent
#   url = "http://localhost:8080/jolokia"
#   # username = ""
#   # password = ""
#   # response_timeout = "5s"
#
#   ## Optional TLS config
#   # tls_ca   = "/var/private/ca.pem"
#   # tls_cert = "/var/private/client.pem"
#   # tls_key  = "/var/private/client-key.pem"
#   # insecure_skip_verify = false
#
#   ## Add proxy targets to query
#   # default_target_username = ""
#   # default_target_password = ""
#   [[inputs.jolokia2_proxy.target]]
#     url = "service:jmx:rmi:///jndi/rmi://targethost:9999/jmxrmi"
#     # username = ""
#     # password = ""
#
#   ## Add metrics to read
#   [[inputs.jolokia2_proxy.metric]]
#     name  = "java_runtime"
#     mbean = "java.lang:type=Runtime"
#     paths = ["Uptime"]


# # Read Kapacitor-formatted JSON metrics from one or more HTTP endpoints
# [[inputs.kapacitor]]
#   ## Multiple URLs from which to read Kapacitor-formatted JSON
#   ## Default is "http://localhost:9092/kapacitor/v1/debug/vars".
#   urls = [
#     "http://localhost:9092/kapacitor/v1/debug/vars"
#   ]
#
#   ## Time limit for http requests
#   timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Get kernel statistics from /proc/vmstat
# [[inputs.kernel_vmstat]]
#   # no configuration


# # Read status information from one or more Kibana servers
# [[inputs.kibana]]
#   ## Specify a list of one or more Kibana servers
#   servers = ["http://localhost:5601"]
#
#   ## Timeout for HTTP requests
#   timeout = "5s"
#
#   ## HTTP Basic Auth credentials
#   # username = "username"
#   # password = "pa$$word"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Read metrics from the Kubernetes api
# [[inputs.kube_inventory]]
#   ## URL for the Kubernetes API
#   url = "https://127.0.0.1"
#
#   ## Namespace to use. Set to "" to use all namespaces.
#   # namespace = "default"
#
#   ## Use bearer token for authorization. ('bearer_token' takes priority)
#   ## If both of these are empty, we'll use the default serviceaccount:
#   ## at: /run/secrets/kubernetes.io/serviceaccount/token
#   # bearer_token = "/path/to/bearer/token"
#   ## OR
#   # bearer_token_string = "abc_123"
#
#   ## Set response_timeout (default 5 seconds)
#   # response_timeout = "5s"
#
#   ## Optional Resources to exclude from gathering
#   ## Leave them with blank with try to gather everything available.
#   ## Values can be - "daemonsets", deployments", "endpoints", "ingress", "nodes",
#   ## "persistentvolumes", "persistentvolumeclaims", "pods", "services", "statefulsets"
#   # resource_exclude = [ "deployments", "nodes", "statefulsets" ]
#
#   ## Optional Resources to include when gathering
#   ## Overrides resource_exclude if both set.
#   # resource_include = [ "deployments", "nodes", "statefulsets" ]
#
#   ## selectors to include and exclude as tags.  Globs accepted.
#   ## Note that an empty array for both will include all selectors as tags
#   ## selector_exclude overrides selector_include if both set.
#   # selector_include = []
#   # selector_exclude = ["*"]
#
#   ## Optional TLS Config
#   # tls_ca = "/path/to/cafile"
#   # tls_cert = "/path/to/certfile"
#   # tls_key = "/path/to/keyfile"
#   # tls_server_name = "kubernetes.example.com"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Read metrics from the kubernetes kubelet api
# [[inputs.kubernetes]]
#   ## URL for the kubelet
#   url = "http://127.0.0.1:10255"
#
#   ## Use bearer token for authorization. ('bearer_token' takes priority)
#   ## If both of these are empty, we'll use the default serviceaccount:
#   ## at: /run/secrets/kubernetes.io/serviceaccount/token
#   # bearer_token = "/path/to/bearer/token"
#   ## OR
#   # bearer_token_string = "abc_123"
#
#   ## Pod labels to be added as tags.  An empty array for both include and
#   ## exclude will include all labels.
#   # label_include = []
#   # label_exclude = ["*"]
#
#   ## Set response_timeout (default 5 seconds)
#   # response_timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = /path/to/cafile
#   # tls_cert = /path/to/certfile
#   # tls_key = /path/to/keyfile
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Read metrics from a LeoFS Server via SNMP
# [[inputs.leofs]]
#   ## An array of URLs of the form:
#   ##   host [ ":" port]
#   servers = ["127.0.0.1:4020"]


# # Provides Linux sysctl fs metrics
# [[inputs.linux_sysctl_fs]]
#   # no configuration


# # Read metrics exposed by Logstash
# [[inputs.logstash]]
#   ## The URL of the exposed Logstash API endpoint.
#   url = "http://127.0.0.1:9600"
#
#   ## Use Logstash 5 single pipeline API, set to true when monitoring
#   ## Logstash 5.
#   # single_pipeline = false
#
#   ## Enable optional collection components.  Can contain
#   ## "pipelines", "process", and "jvm".
#   # collect = ["pipelines", "process", "jvm"]
#
#   ## Timeout for HTTP requests.
#   # timeout = "5s"
#
#   ## Optional HTTP Basic Auth credentials.
#   # username = "username"
#   # password = "pa$$word"
#
#   ## Optional TLS Config.
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#
#   ## Use TLS but skip chain & host verification.
#   # insecure_skip_verify = false
#
#   ## Optional HTTP headers.
#   # [inputs.logstash.headers]
#   #   "X-Special-Header" = "Special-Value"


# # Read metrics from local Lustre service on OST, MDS
# [[inputs.lustre2]]
#   ## An array of /proc globs to search for Lustre stats
#   ## If not specified, the default will work on Lustre 2.5.x
#   ##
#   # ost_procfiles = [
#   #   "/proc/fs/lustre/obdfilter/*/stats",
#   #   "/proc/fs/lustre/osd-ldiskfs/*/stats",
#   #   "/proc/fs/lustre/obdfilter/*/job_stats",
#   # ]
#   # mds_procfiles = [
#   #   "/proc/fs/lustre/mdt/*/md_stats",
#   #   "/proc/fs/lustre/mdt/*/job_stats",
#   # ]


# # Read metrics about LVM physical volumes, volume groups, logical volumes.
# [[inputs.lvm]]
# ## Use sudo to run LVM commands
# use_sudo = false


# # Gathers metrics from the /3.0/reports MailChimp API
# [[inputs.mailchimp]]
#   ## MailChimp API key
#   ## get from https://admin.mailchimp.com/account/api/
#   api_key = "" # required
#   ## Reports for campaigns sent more than days_old ago will not be collected.
#   ## 0 means collect all.
#   days_old = 0
#   ## Campaign ID to get, if empty gets all campaigns, this option overrides days_old
#   # campaign_id = ""


# # Retrieves information on a specific host in a MarkLogic Cluster
# [[inputs.marklogic]]
#   ## Base URL of the MarkLogic HTTP Server.
#   url = "http://localhost:8002"
#
#   ## List of specific hostnames to retrieve information. At least (1) required.
#   # hosts = ["hostname1", "hostname2"]
#
#   ## Using HTTP Basic Authentication. Management API requires 'manage-user' role privileges
#   # username = "myuser"
#   # password = "mypassword"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Read metrics from one or many mcrouter servers
# [[inputs.mcrouter]]
#   ## An array of address to gather stats about. Specify an ip or hostname
#   ## with port. ie tcp://localhost:11211, tcp://10.0.0.1:11211, etc.
# 	servers = ["tcp://localhost:11211", "unix:///var/run/mcrouter.sock"]
#
# 	## Timeout for metric collections from all servers.  Minimum timeout is "1s".
#   # timeout = "5s"


# # Get md array statistics from /proc/mdstat
# [[inputs.mdstat]]
# 	## Sets file path
# 	## If not specified, then default is /proc/mdstat
# 	# file_name = "/proc/mdstat"


# # Read metrics from one or many memcached servers
# [[inputs.memcached]]
#   ## An array of address to gather stats about. Specify an ip on hostname
#   ## with optional port. ie localhost, 10.0.0.1:11211, etc.
#   servers = ["localhost:11211"]
#   # unix_sockets = ["/var/run/memcached.sock"]
#
#   ## Optional TLS Config
#   # enable_tls = true
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## If false, skip chain & host verification
#   # insecure_skip_verify = true


# # Telegraf plugin for gathering metrics from N Mesos masters
# [[inputs.mesos]]
#   ## Timeout, in ms.
#   timeout = 100
#
#   ## A list of Mesos masters.
#   masters = ["http://localhost:5050"]
#
#   ## Master metrics groups to be collected, by default, all enabled.
#   master_collections = [
#     "resources",
#     "master",
#     "system",
#     "agents",
#     "frameworks",
#     "framework_offers",
#     "tasks",
#     "messages",
#     "evqueue",
#     "registrar",
#     "allocator",
#   ]
#
#   ## A list of Mesos slaves, default is []
#   # slaves = []
#
#   ## Slave metrics groups to be collected, by default, all enabled.
#   # slave_collections = [
#   #   "resources",
#   #   "agent",
#   #   "system",
#   #   "executors",
#   #   "tasks",
#   #   "messages",
#   # ]
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Collects scores from a Minecraft server's scoreboard using the RCON protocol
# [[inputs.minecraft]]
#   ## Address of the Minecraft server.
#   # server = "localhost"
#
#   ## Server RCON Port.
#   # port = "25575"
#
#   ## Server RCON Password.
#   password = ""
#
#   ## Uncomment to remove deprecated metric components.
#   # tagdrop = ["server"]


# # Generate metrics for test and demonstration purposes
# [[inputs.mock]]
#   ## Set the metric name to use for reporting
#   metric_name = "mock"
#
#   ## Optional string key-value pairs of tags to add to all metrics
#   # [inputs.mock.tags]
#   # "key" = "value"
#
#   ## One or more mock data fields *must* be defined.
#   ##
#   ## [[inputs.mock.random]]
#   ##   name = "rand"
#   ##   min = 1.0
#   ##   max = 6.0
#   ## [[inputs.mock.sine_wave]]
#   ##   name = "wave"
#   ##   amplitude = 1.0
#   ##   period = 0.5
#   ## [[inputs.mock.step]]
#   ##   name = "plus_one"
#   ##   start = 0.0
#   ##   step = 1.0
#   ## [[inputs.mock.stock]]
#   ##   name = "abc"
#   ##   price = 50.00
#   ##   volatility = 0.2


# # Retrieve data from MODBUS slave devices
# [[inputs.modbus]]
#   ## Connection Configuration
#   ##
#   ## The plugin supports connections to PLCs via MODBUS/TCP, RTU over TCP, ASCII over TCP or
#   ## via serial line communication in binary (RTU) or readable (ASCII) encoding
#   ##
#   ## Device name
#   name = "Device"
#
#   ## Slave ID - addresses a MODBUS device on the bus
#   ## Range: 0 - 255 [0 = broadcast; 248 - 255 = reserved]
#   slave_id = 1
#
#   ## Timeout for each request
#   timeout = "1s"
#
#   ## Maximum number of retries and the time to wait between retries
#   ## when a slave-device is busy.
#   # busy_retries = 0
#   # busy_retries_wait = "100ms"
#
#   # TCP - connect via Modbus/TCP
#   controller = "tcp://localhost:502"
#
#   ## Serial (RS485; RS232)
#   # controller = "file:///dev/ttyUSB0"
#   # baud_rate = 9600
#   # data_bits = 8
#   # parity = "N"
#   # stop_bits = 1
#
#   ## Trace the connection to the modbus device as debug messages
#   ## Note: You have to enable telegraf's debug mode to see those messages!
#   # debug_connection = false
#
#   ## For Modbus over TCP you can choose between "TCP", "RTUoverTCP" and "ASCIIoverTCP"
#   ## default behaviour is "TCP" if the controller is TCP
#   ## For Serial you can choose between "RTU" and "ASCII"
#   # transmission_mode = "RTU"
#
# 	## Define the configuration schema
#   ##  |---register -- define fields per register type in the original style (only supports one slave ID)
#   ##  |---request  -- define fields on a requests base
#   configuration_type = "register"
#
#   ## Per register definition
#   ##
#
#   ## Digital Variables, Discrete Inputs and Coils
#   ## measurement - the (optional) measurement name, defaults to "modbus"
#   ## name        - the variable name
#   ## address     - variable address
#
#   discrete_inputs = [
#     { name = "start",          address = [0]},
#     { name = "stop",           address = [1]},
#     { name = "reset",          address = [2]},
#     { name = "emergency_stop", address = [3]},
#   ]
#   coils = [
#     { name = "motor1_run",     address = [0]},
#     { name = "motor1_jog",     address = [1]},
#     { name = "motor1_stop",    address = [2]},
#   ]
#
#   ## Analog Variables, Input Registers and Holding Registers
#   ## measurement - the (optional) measurement name, defaults to "modbus"
#   ## name        - the variable name
#   ## byte_order  - the ordering of bytes
#   ##  |---AB, ABCD   - Big Endian
#   ##  |---BA, DCBA   - Little Endian
#   ##  |---BADC       - Mid-Big Endian
#   ##  |---CDAB       - Mid-Little Endian
#   ## data_type  - INT16, UINT16, INT32, UINT32, INT64, UINT64,
#   ##              FLOAT32-IEEE, FLOAT64-IEEE (the IEEE 754 binary representation)
#   ##              FLOAT32, FIXED, UFIXED (fixed-point representation on input)
#   ## scale      - the final numeric variable representation
#   ## address    - variable address
#
#   holding_registers = [
#     { name = "power_factor", byte_order = "AB",   data_type = "FIXED", scale=0.01,  address = [8]},
#     { name = "voltage",      byte_order = "AB",   data_type = "FIXED", scale=0.1,   address = [0]},
#     { name = "energy",       byte_order = "ABCD", data_type = "FIXED", scale=0.001, address = [5,6]},
#     { name = "current",      byte_order = "ABCD", data_type = "FIXED", scale=0.001, address = [1,2]},
#     { name = "frequency",    byte_order = "AB",   data_type = "UFIXED", scale=0.1,  address = [7]},
#     { name = "power",        byte_order = "ABCD", data_type = "UFIXED", scale=0.1,  address = [3,4]},
#   ]
#   input_registers = [
#     { name = "tank_level",   byte_order = "AB",   data_type = "INT16",   scale=1.0,     address = [0]},
#     { name = "tank_ph",      byte_order = "AB",   data_type = "INT16",   scale=1.0,     address = [1]},
#     { name = "pump1_speed",  byte_order = "ABCD", data_type = "INT32",   scale=1.0,     address = [3,4]},
#   ]
#
#
#   ## Per request definition
#   ##
#
#   ## Define a request sent to the device
#   ## Multiple of those requests can be defined. Data will be collated into metrics at the end of data collection.
#   # [[inputs.modbus.request]]
#     ## ID of the modbus slave device to query.
#     ## If you need to query multiple slave-devices, create several "request" definitions.
#     # slave_id = 0
#
#     ## Byte order of the data.
#     ##  |---ABCD or MSW-BE -- Big Endian (Motorola)
#     ##  |---DCBA or LSW-LE -- Little Endian (Intel)
#     ##  |---BADC or MSW-LE -- Big Endian with byte swap
#     ##  |---CDAB or LSW-BE -- Little Endian with byte swap
#     # byte_order = "ABCD"
#
#     ## Type of the register for the request
#     ## Can be "coil", "discrete", "holding" or "input"
#     # register = "holding"
#
#     ## Name of the measurement.
#     ## Can be overriden by the individual field definitions. Defaults to "modbus"
#     # measurement = "modbus"
#
#     ## Field definitions
#     ## Analog Variables, Input Registers and Holding Registers
#     ## address        - address of the register to query. For coil and discrete inputs this is the bit address.
#     ## name *1        - field name
#     ## type *1,2      - type of the modbus field, can be INT16, UINT16, INT32, UINT32, INT64, UINT64 and
#     ##                  FLOAT32, FLOAT64 (IEEE 754 binary representation)
#     ## scale *1,2     - (optional) factor to scale the variable with
#     ## output *1,2    - (optional) type of resulting field, can be INT64, UINT64 or FLOAT64. Defaults to FLOAT64 if
#     ##                  "scale" is provided and to the input "type" class otherwise (i.e. INT* -> INT64, etc).
#     ## measurement *1 - (optional) measurement name, defaults to the setting of the request
#     ## omit           - (optional) omit this field. Useful to leave out single values when querying many registers
#     ##                  with a single request. Defaults to "false".
#     ##
#     ## *1: Those fields are ignored if field is omitted ("omit"=true)
#     ##
#     ## *2: Thise fields are ignored for both "coil" and "discrete"-input type of registers. For those register types
#     ##     the fields are output as zero or one in UINT64 format by default.
#
#     ## Coil / discrete input example
#     # fields = [
#     #   { address=0, name="motor1_run"},
#     #   { address=1, name="jog", measurement="motor"},
#     #   { address=2, name="motor1_stop", omit=true},
#     #   { address=3, name="motor1_overheating"},
#     # ]
#
#     ## Per-request tags
#     ## These tags take precedence over predefined tags.
#     # [[inputs.modbus.request.tags]]
#     #	  name = "value"
#
#     ## Holding / input example
#     ## All of those examples will result in FLOAT64 field outputs
#     # fields = [
#     #   { address=0, name="voltage",      type="INT16",   scale=0.1   },
#     #   { address=1, name="current",      type="INT32",   scale=0.001 },
#     #   { address=3, name="power",        type="UINT32",  omit=true   },
#     #   { address=5, name="energy",       type="FLOAT32", scale=0.001, measurement="W" },
#     #   { address=7, name="frequency",    type="UINT32",  scale=0.1   },
#     #   { address=8, name="power_factor", type="INT64",   scale=0.01  },
#     # ]
#
#     ## Holding / input example with type conversions
#     # fields = [
#     #   { address=0, name="rpm",         type="INT16"                   },  # will result in INT64 field
#     #   { address=1, name="temperature", type="INT16", scale=0.1        },  # will result in FLOAT64 field
#     #   { address=2, name="force",       type="INT32", output="FLOAT64" },  # will result in FLOAT64 field
#     #   { address=4, name="hours",       type="UINT32"                  },  # will result in UIN64 field
#     # ]
#
#     ## Per-request tags
# 		## These tags take precedence over predefined tags.
#     # [[inputs.modbus.request.tags]]
#     #	  name = "value"
#
#
#
#   ## Enable workarounds required by some devices to work correctly
#   # [inputs.modbus.workarounds]
#     ## Pause between read requests sent to the device. This might be necessary for (slow) serial devices.
#     # pause_between_requests = "0ms"
#     ## Close the connection after every gather cycle. Usually the plugin closes the connection after a certain
#     ## idle-timeout, however, if you query a device with limited simultaneous connectivity (e.g. serial devices)
#     ## from multiple instances you might want to only stay connected during gather and disconnect afterwards.
#     # close_connection_after_gather = false


# # Read metrics from one or many MongoDB servers
# [[inputs.mongodb]]
#   ## An array of URLs of the form:
#   ##   "mongodb://" [user ":" pass "@"] host [ ":" port]
#   ## For example:
#   ##   mongodb://user:auth_key@10.10.3.30:27017,
#   ##   mongodb://10.10.3.33:18832,
#   servers = ["mongodb://127.0.0.1:27017?connect=direct"]
#
#   ## When true, collect cluster status
#   ## Note that the query that counts jumbo chunks triggers a COLLSCAN, which
#   ## may have an impact on performance.
#   # gather_cluster_status = true
#
#   ## When true, collect per database stats
#   # gather_perdb_stats = false
#
#   ## When true, collect per collection stats
#   # gather_col_stats = false
#
#   ## When true, collect usage statistics for each collection
#   ## (insert, update, queries, remove, getmore, commands etc...).
#   # gather_top_stat = false
#
#   ## List of db where collections stats are collected
#   ## If empty, all db are concerned
#   # col_stats_dbs = ["local"]
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Read metrics and status information about processes managed by Monit
# [[inputs.monit]]
#   ## Monit HTTPD address
#   address = "http://127.0.0.1:2812"
#
#   ## Username and Password for Monit
#   # username = ""
#   # password = ""
#
#   ## Amount of time allowed to complete the HTTP request
#   # timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Aggregates the contents of multiple files into a single point
# [[inputs.multifile]]
#   ## Base directory where telegraf will look for files.
#   ## Omit this option to use absolute paths.
#   base_dir = "/sys/bus/i2c/devices/1-0076/iio:device0"
#
#   ## If true, Telegraf discard all data when a single file can't be read.
#   ## Else, Telegraf omits the field generated from this file.
#   # fail_early = true
#
#   ## Files to parse each interval.
#   [[inputs.multifile.file]]
#     file = "in_pressure_input"
#     dest = "pressure"
#     conversion = "float"
#   [[inputs.multifile.file]]
#     file = "in_temp_input"
#     dest = "temperature"
#     conversion = "float(3)"
#   [[inputs.multifile.file]]
#     file = "in_humidityrelative_input"
#     dest = "humidityrelative"
#     conversion = "float(3)"


# # Read metrics from one or many mysql servers
# [[inputs.mysql]]
#   ## specify servers via a url matching:
#   ##  [username[:password]@][protocol[(address)]]/[?tls=[true|false|skip-verify|custom]]
#   ##  see https://github.com/go-sql-driver/mysql#dsn-data-source-name
#   ##  e.g.
#   ##    servers = ["user:passwd@tcp(127.0.0.1:3306)/?tls=false"]
#   ##    servers = ["user@tcp(127.0.0.1:3306)/?tls=false"]
#   #
#   ## If no servers are specified, then localhost is used as the host.
#   servers = ["tcp(127.0.0.1:3306)/"]
#
#   ## Selects the metric output format.
#   ##
#   ## This option exists to maintain backwards compatibility, if you have
#   ## existing metrics do not set or change this value until you are ready to
#   ## migrate to the new format.
#   ##
#   ## If you do not have existing metrics from this plugin set to the latest
#   ## version.
#   ##
#   ## Telegraf >=1.6: metric_version = 2
#   ##           <1.6: metric_version = 1 (or unset)
#   metric_version = 2
#
#   ## if the list is empty, then metrics are gathered from all database tables
#   # table_schema_databases = []
#
#   ## gather metrics from INFORMATION_SCHEMA.TABLES for databases provided above list
#   # gather_table_schema = false
#
#   ## gather thread state counts from INFORMATION_SCHEMA.PROCESSLIST
#   # gather_process_list = false
#
#   ## gather user statistics from INFORMATION_SCHEMA.USER_STATISTICS
#   # gather_user_statistics = false
#
#   ## gather auto_increment columns and max values from information schema
#   # gather_info_schema_auto_inc = false
#
#   ## gather metrics from INFORMATION_SCHEMA.INNODB_METRICS
#   # gather_innodb_metrics = false
#
#   ## gather metrics from SHOW SLAVE STATUS command output
#   # gather_slave_status = false
#
#   ## gather metrics from all channels from SHOW SLAVE STATUS command output
#   # gather_all_slave_channels = false
#
#   ## use MariaDB dialect for all channels SHOW SLAVE STATUS
#   # mariadb_dialect = false
#
#   ## gather metrics from SHOW BINARY LOGS command output
#   # gather_binary_logs = false
#
#   ## gather metrics from PERFORMANCE_SCHEMA.GLOBAL_VARIABLES
#   # gather_global_variables = true
#
#   ## gather metrics from PERFORMANCE_SCHEMA.TABLE_IO_WAITS_SUMMARY_BY_TABLE
#   # gather_table_io_waits = false
#
#   ## gather metrics from PERFORMANCE_SCHEMA.TABLE_LOCK_WAITS
#   # gather_table_lock_waits = false
#
#   ## gather metrics from PERFORMANCE_SCHEMA.TABLE_IO_WAITS_SUMMARY_BY_INDEX_USAGE
#   # gather_index_io_waits = false
#
#   ## gather metrics from PERFORMANCE_SCHEMA.EVENT_WAITS
#   # gather_event_waits = false
#
#   ## gather metrics from PERFORMANCE_SCHEMA.FILE_SUMMARY_BY_EVENT_NAME
#   # gather_file_events_stats = false
#
#   ## gather metrics from PERFORMANCE_SCHEMA.EVENTS_STATEMENTS_SUMMARY_BY_DIGEST
#   # gather_perf_events_statements = false
#
#   ## the limits for metrics form perf_events_statements
#   # perf_events_statements_digest_text_limit = 120
#   # perf_events_statements_limit = 250
#   # perf_events_statements_time_limit = 86400
#
#   ## gather metrics from PERFORMANCE_SCHEMA.EVENTS_STATEMENTS_SUMMARY_BY_ACCOUNT_BY_EVENT_NAME
#   # gather_perf_sum_per_acc_per_event         = false
#
#   ## list of events to be gathered for gather_perf_sum_per_acc_per_event
#   ## in case of empty list all events will be gathered
#   # perf_summary_events                       = []
#
#   ## Some queries we may want to run less often (such as SHOW GLOBAL VARIABLES)
#   ##   example: interval_slow = "30m"
#   # interval_slow = ""
#
#   ## Optional TLS Config (will be used if tls=custom parameter specified in server uri)
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Provides metrics about the state of a NATS server
# [[inputs.nats]]
#   ## The address of the monitoring endpoint of the NATS server
#   server = "http://localhost:8222"
#
#   ## Maximum time to receive response
#   # response_timeout = "5s"


# # Neptune Apex data collector
# [[inputs.neptune_apex]]
#   ## The Neptune Apex plugin reads the publicly available status.xml data from a local Apex.
#   ## Measurements will be logged under "apex".
#
#   ## The base URL of the local Apex(es). If you specify more than one server, they will
#   ## be differentiated by the "source" tag.
#   servers = [
#     "http://apex.local",
#   ]
#
#   ## The response_timeout specifies how long to wait for a reply from the Apex.
#   #response_timeout = "5s"


# # Read metrics about network interface usage
# [[inputs.net]]
#   ## By default, telegraf gathers stats from any up interface (excluding loopback)
#   ## Setting interfaces will tell it to gather these explicit interfaces,
#   ## regardless of status.
#   ##
#   # interfaces = ["eth0"]
#   ##
#   ## On linux systems telegraf also collects protocol stats.
#   ## Setting ignore_protocol_stats to true will skip reporting of protocol metrics.
#   ##
#   # ignore_protocol_stats = false
#   ##


# # Collect response time of a TCP or UDP connection
# [[inputs.net_response]]
#   ## Protocol, must be "tcp" or "udp"
#   ## NOTE: because the "udp" protocol does not respond to requests, it requires
#   ## a send/expect string pair (see below).
#   protocol = "tcp"
#   ## Server address (default localhost)
#   address = "localhost:80"
#
#   ## Set timeout
#   # timeout = "1s"
#
#   ## Set read timeout (only used if expecting a response)
#   # read_timeout = "1s"
#
#   ## The following options are required for UDP checks. For TCP, they are
#   ## optional. The plugin will send the given string to the server and then
#   ## expect to receive the given 'expect' string back.
#   ## string sent to the server
#   # send = "ssh"
#   ## expected string in answer
#   # expect = "ssh"
#
#   ## Uncomment to remove deprecated fields
#   # fielddrop = ["result_type", "string_found"]


# # Read TCP metrics such as established, time wait and sockets counts.
# [[inputs.netstat]]
#   # no configuration


# # Read per-mount NFS client metrics from /proc/self/mountstats
# [[inputs.nfsclient]]
#   ## Read more low-level metrics (optional, defaults to false)
#   # fullstat = false
#
#   ## List of mounts to explictly include or exclude (optional)
#   ## The pattern (Go regexp) is matched against the mount point (not the
#   ## device being mounted).  If include_mounts is set, all mounts are ignored
#   ## unless present in the list. If a mount is listed in both include_mounts
#   ## and exclude_mounts, it is excluded.  Go regexp patterns can be used.
#   # include_mounts = []
#   # exclude_mounts = []
#
#   ## List of operations to include or exclude from collecting.  This applies
#   ## only when fullstat=true.  Symantics are similar to {include,exclude}_mounts:
#   ## the default is to collect everything; when include_operations is set, only
#   ## those OPs are collected; when exclude_operations is set, all are collected
#   ## except those listed.  If include and exclude are set, the OP is excluded.
#   ## See /proc/self/mountstats for a list of valid operations; note that
#   ## NFSv3 and NFSv4 have different lists.  While it is not possible to
#   ## have different include/exclude lists for NFSv3/4, unused elements
#   ## in the list should be okay.  It is possible to have different lists
#   ## for different mountpoints:  use mulitple [[input.nfsclient]] stanzas,
#   ## with their own lists.  See "include_mounts" above, and be careful of
#   ## duplicate metrics.
#   # include_operations = []
#   # exclude_operations = []


# # Read Nginx's basic status information (ngx_http_stub_status_module)
# [[inputs.nginx]]
#   # An array of Nginx stub_status URI to gather stats.
#   urls = ["http://localhost/server_status"]
#
#   ## Optional TLS Config
#   tls_ca = "/etc/telegraf/ca.pem"
#   tls_cert = "/etc/telegraf/cert.cer"
#   tls_key = "/etc/telegraf/key.key"
#   ## Use TLS but skip chain & host verification
#   insecure_skip_verify = false
#
#   # HTTP response timeout (default: 5s)
#   response_timeout = "5s"


# # Read Nginx Plus' full status information (ngx_http_status_module)
# [[inputs.nginx_plus]]
#   ## An array of ngx_http_status_module or status URI to gather stats.
#   urls = ["http://localhost/status"]
#
#   # HTTP response timeout (default: 5s)
#   response_timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Read Nginx Plus Api documentation
# [[inputs.nginx_plus_api]]
#   ## An array of API URI to gather stats.
#   urls = ["http://localhost/api"]
#
#   # Nginx API version, default: 3
#   # api_version = 3
#
#   # HTTP response timeout (default: 5s)
#   response_timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Read Nginx virtual host traffic status module information (nginx-module-sts)
# [[inputs.nginx_sts]]
#   ## An array of ngx_http_status_module or status URI to gather stats.
#   urls = ["http://localhost/status"]
#
#   ## HTTP response timeout (default: 5s)
#   response_timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Read nginx_upstream_check module status information (https://github.com/yaoweibin/nginx_upstream_check_module)
# [[inputs.nginx_upstream_check]]
#   ## An URL where Nginx Upstream check module is enabled
#   ## It should be set to return a JSON formatted response
#   url = "http://127.0.0.1/status?format=json"
#
#   ## HTTP method
#   # method = "GET"
#
#   ## Optional HTTP headers
#   # headers = {"X-Special-Header" = "Special-Value"}
#
#   ## Override HTTP "Host" header
#   # host_header = "check.example.com"
#
#   ## Timeout for HTTP requests
#   timeout = "5s"
#
#   ## Optional HTTP Basic Auth credentials
#   # username = "username"
#   # password = "pa$$word"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Read Nginx virtual host traffic status module information (nginx-module-vts)
# [[inputs.nginx_vts]]
#   ## An array of ngx_http_status_module or status URI to gather stats.
#   urls = ["http://localhost/status"]
#
#   ## HTTP response timeout (default: 5s)
#   response_timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Read metrics from the Nomad API
# [[inputs.nomad]]
#   ## URL for the Nomad agent
#   # url = "http://127.0.0.1:4646"
#
#   ## Set response_timeout (default 5 seconds)
#   # response_timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = /path/to/cafile
#   # tls_cert = /path/to/certfile
#   # tls_key = /path/to/keyfile


# # A plugin to collect stats from the NSD authoritative DNS name server
# [[inputs.nsd]]
#   ## Address of server to connect to, optionally ':port'. Defaults to the
#   ## address in the nsd config file.
#   server = "127.0.0.1:8953"
#
#   ## If running as a restricted user you can prepend sudo for additional access:
#   # use_sudo = false
#
#   ## The default location of the nsd-control binary can be overridden with:
#   # binary = "/usr/sbin/nsd-control"
#
#   ## The default location of the nsd config file can be overridden with:
#   # config_file = "/etc/nsd/nsd.conf"
#
#   ## The default timeout of 1s can be overridden with:
#   # timeout = "1s"


# # Read NSQ topic and channel statistics.
# [[inputs.nsq]]
#   ## An array of NSQD HTTP API endpoints
#   endpoints  = ["http://localhost:4151"]
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Collect kernel snmp counters and network interface statistics
# [[inputs.nstat]]
#   ## file paths for proc files. If empty default paths will be used:
#   ##    /proc/net/netstat, /proc/net/snmp, /proc/net/snmp6
#   ## These can also be overridden with env variables, see README.
#   proc_net_netstat = "/proc/net/netstat"
#   proc_net_snmp = "/proc/net/snmp"
#   proc_net_snmp6 = "/proc/net/snmp6"
#   ## dump metrics with 0 values too
#   dump_zeros       = true


# # Get standard NTP query metrics, requires ntpq executable.
# [[inputs.ntpq]]
#   ## If false, set the -n ntpq flag. Can reduce metric gather time.
#   dns_lookup = true


# # Pulls statistics from nvidia GPUs attached to the host
# [[inputs.nvidia_smi]]
#   ## Optional: path to nvidia-smi binary, defaults "/usr/bin/nvidia-smi"
#   ## We will first try to locate the nvidia-smi binary with the explicitly specified value (or default value),
#   ## if it is not found, we will try to locate it on PATH(exec.LookPath), if it is still not found, an error will be returned
#   # bin_path = "/usr/bin/nvidia-smi"
#
#   ## Optional: timeout for GPU polling
#   # timeout = "5s"


# # Retrieve data from OPCUA devices
# [[inputs.opcua]]
#   ## Metric name
#   # name = "opcua"
#   #
#   ## OPC UA Endpoint URL
#   # endpoint = "opc.tcp://localhost:4840"
#   #
#   ## Maximum time allowed to establish a connect to the endpoint.
#   # connect_timeout = "10s"
#   #
#   ## Maximum time allowed for a request over the estabilished connection.
#   # request_timeout = "5s"
#   #
#   ## Security policy, one of "None", "Basic128Rsa15", "Basic256",
#   ## "Basic256Sha256", or "auto"
#   # security_policy = "auto"
#   #
#   ## Security mode, one of "None", "Sign", "SignAndEncrypt", or "auto"
#   # security_mode = "auto"
#   #
#   ## Path to cert.pem. Required when security mode or policy isn't "None".
#   ## If cert path is not supplied, self-signed cert and key will be generated.
#   # certificate = "/etc/telegraf/cert.pem"
#   #
#   ## Path to private key.pem. Required when security mode or policy isn't "None".
#   ## If key path is not supplied, self-signed cert and key will be generated.
#   # private_key = "/etc/telegraf/key.pem"
#   #
#   ## Authentication Method, one of "Certificate", "UserName", or "Anonymous".  To
#   ## authenticate using a specific ID, select 'Certificate' or 'UserName'
#   # auth_method = "Anonymous"
#   #
#   ## Username. Required for auth_method = "UserName"
#   # username = ""
#   #
#   ## Password. Required for auth_method = "UserName"
#   # password = ""
#   #
#   ## Option to select the metric timestamp to use. Valid options are:
#   ##     "gather" -- uses the time of receiving the data in telegraf
#   ##     "server" -- uses the timestamp provided by the server
#   ##     "source" -- uses the timestamp provided by the source
#   # timestamp = "gather"
#   #
#   ## Node ID configuration
#   ## name              - field name to use in the output
#   ## namespace         - OPC UA namespace of the node (integer value 0 thru 3)
#   ## identifier_type   - OPC UA ID type (s=string, i=numeric, g=guid, b=opaque)
#   ## identifier        - OPC UA ID (tag as shown in opcua browser)
#   ## Example:
#   ## {name="ProductUri", namespace="0", identifier_type="i", identifier="2262"}
#   # nodes = [
#   #  {name="", namespace="", identifier_type="", identifier=""},
#   #  {name="", namespace="", identifier_type="", identifier=""},
#   #]
#   #
#   ## Node Group
#   ## Sets defaults for OPC UA namespace and ID type so they aren't required in
#   ## every node.  A group can also have a metric name that overrides the main
#   ## plugin metric name.
#   ##
#   ## Multiple node groups are allowed
#   #[[inputs.opcua.group]]
#   ## Group Metric name. Overrides the top level name.  If unset, the
#   ## top level name is used.
#   # name =
#   #
#   ## Group default namespace. If a node in the group doesn't set its
#   ## namespace, this is used.
#   # namespace =
#   #
#   ## Group default identifier type. If a node in the group doesn't set its
#   ## namespace, this is used.
#   # identifier_type =
#   #
#   ## Node ID Configuration.  Array of nodes with the same settings as above.
#   # nodes = [
#   #  {name="", namespace="", identifier_type="", identifier=""},
#   #  {name="", namespace="", identifier_type="", identifier=""},
#   #]
#
#   ## Enable workarounds required by some devices to work correctly
#   # [inputs.opcua.workarounds]
#     ## Set additional valid status codes, StatusOK (0x0) is always considered valid
#     # additional_valid_status_codes = ["0xC0"]


# # OpenLDAP cn=Monitor plugin
# [[inputs.openldap]]
#   host = "localhost"
#   port = 389
#
#   # ldaps, starttls, or no encryption. default is an empty string, disabling all encryption.
#   # note that port will likely need to be changed to 636 for ldaps
#   # valid options: "" | "starttls" | "ldaps"
#   tls = ""
#
#   # skip peer certificate verification. Default is false.
#   insecure_skip_verify = false
#
#   # Path to PEM-encoded Root certificate to use to verify server certificate
#   tls_ca = "/etc/ssl/certs.pem"
#
#   # dn/password to bind with. If bind_dn is empty, an anonymous bind is performed.
#   bind_dn = ""
#   bind_password = ""
#
#   # Reverse metric names so they sort more naturally. Recommended.
#   # This defaults to false if unset, but is set to true when generating a new config
#   reverse_metric_names = true


# # Get standard NTP query metrics from OpenNTPD.
# [[inputs.openntpd]]
#   ## Run ntpctl binary with sudo.
#   # use_sudo = false
#
#   ## Location of the ntpctl binary.
#   # binary = "/usr/sbin/ntpctl"
#
#   ## Maximum time the ntpctl binary is allowed to run.
#   # timeout = "5ms"


# # A plugin to collect stats from Opensmtpd - a validating, recursive, and caching DNS resolver 
# [[inputs.opensmtpd]]
#   ## If running as a restricted user you can prepend sudo for additional access:
#   #use_sudo = false
#
#   ## The default location of the smtpctl binary can be overridden with:
#   binary = "/usr/sbin/smtpctl"
#
#   ## The default timeout of 1000ms can be overridden with (in milliseconds):
#   timeout = 1000


# # Collects performance metrics from OpenStack services
# [[inputs.openstack]]
#   ## The recommended interval to poll is '30m'
#
#   ## The identity endpoint to authenticate against and get the service catalog from.
#   authentication_endpoint = "https://my.openstack.cloud:5000"
#
#   ## The domain to authenticate against when using a V3 identity endpoint.
#   # domain = "default"
#
#   ## The project to authenticate as.
#   # project = "admin"
#
#   ## User authentication credentials. Must have admin rights.
#   username = "admin"
#   password = "password"
#
#   ## Available services are:
#   ## "agents", "aggregates", "flavors", "hypervisors", "networks", "nova_services",
#   ## "ports", "projects", "servers", "services", "stacks", "storage_pools", "subnets", "volumes"
#   # enabled_services = ["services", "projects", "hypervisors", "flavors", "networks", "volumes"]
#
#   ## Collect Server Diagnostics
#   # server_diagnotics = false
#
#   ## output secrets (such as adminPass(for server) and UserID(for volume)).
#   # output_secrets = false
#
#   ## Amount of time allowed to complete the HTTP(s) request.
#   # timeout = "5s"
#
#   ## HTTP Proxy support
#   # http_proxy_url = ""
#
#   ## Optional TLS Config
#   # tls_ca = /path/to/cafile
#   # tls_cert = /path/to/certfile
#   # tls_key = /path/to/keyfile
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## Options for tags received from Openstack
#   # tag_prefix = "openstack_tag_"
#   # tag_value = "true"
#
#   ## Timestamp format for timestamp data recieved from Openstack.
#   ## If false format is unix nanoseconds.
#   # human_readable_timestamps = false
#
#   ## Measure Openstack call duration
#   # measure_openstack_requests = false


# # Read current weather and forecasts data from openweathermap.org
# [[inputs.openweathermap]]
#   ## OpenWeatherMap API key.
#   app_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
#
#   ## City ID's to collect weather data from.
#   city_id = ["5391959"]
#
#   ## Language of the description field. Can be one of "ar", "bg",
#   ## "ca", "cz", "de", "el", "en", "fa", "fi", "fr", "gl", "hr", "hu",
#   ## "it", "ja", "kr", "la", "lt", "mk", "nl", "pl", "pt", "ro", "ru",
#   ## "se", "sk", "sl", "es", "tr", "ua", "vi", "zh_cn", "zh_tw"
#   # lang = "en"
#
#   ## APIs to fetch; can contain "weather" or "forecast".
#   fetch = ["weather", "forecast"]
#
#   ## OpenWeatherMap base URL
#   # base_url = "https://api.openweathermap.org/"
#
#   ## Timeout for HTTP response.
#   # response_timeout = "5s"
#
#   ## Preferred unit system for temperature and wind speed. Can be one of
#   ## "metric", "imperial", or "standard".
#   # units = "metric"
#
#   ## Query interval; OpenWeatherMap updates their weather data every 10
#   ## minutes.
#   interval = "10m"


# # Read metrics of passenger using passenger-status
# [[inputs.passenger]]
#   ## Path of passenger-status.
#   ##
#   ## Plugin gather metric via parsing XML output of passenger-status
#   ## More information about the tool:
#   ##   https://www.phusionpassenger.com/library/admin/apache/overall_status_report.html
#   ##
#   ## If no path is specified, then the plugin simply execute passenger-status
#   ## hopefully it can be found in your PATH
#   command = "passenger-status -v --show=xml"


# # Gather counters from PF
# [[inputs.pf]]
#   ## PF require root access on most systems.
#   ## Setting 'use_sudo' to true will make use of sudo to run pfctl.
#   ## Users must configure sudo to allow telegraf user to run pfctl with no password.
#   ## pfctl can be restricted to only list command "pfctl -s info".
#   use_sudo = false


# # Read metrics of phpfpm, via HTTP status page or socket
# [[inputs.phpfpm]]
#   ## An array of addresses to gather stats about. Specify an ip or hostname
#   ## with optional port and path
#   ##
#   ## Plugin can be configured in three modes (either can be used):
#   ##   - http: the URL must start with http:// or https://, ie:
#   ##       "http://localhost/status"
#   ##       "http://192.168.130.1/status?full"
#   ##
#   ##   - unixsocket: path to fpm socket, ie:
#   ##       "/var/run/php5-fpm.sock"
#   ##      or using a custom fpm status path:
#   ##       "/var/run/php5-fpm.sock:fpm-custom-status-path"
#   ##
#   ##   - fcgi: the URL must start with fcgi:// or cgi://, and port must be present, ie:
#   ##       "fcgi://10.0.0.12:9000/status"
#   ##       "cgi://10.0.10.12:9001/status"
#   ##
#   ## Example of multiple gathering from local socket and remote host
#   ## urls = ["http://192.168.1.20/status", "/tmp/fpm.sock"]
#   urls = ["http://localhost/status"]
#
#   ## Duration allowed to complete HTTP requests.
#   # timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Ping given url(s) and return statistics
# [[inputs.ping]]
#   ## Hosts to send ping packets to.
#   urls = ["example.org"]
#
#   ## Method used for sending pings, can be either "exec" or "native".  When set
#   ## to "exec" the systems ping command will be executed.  When set to "native"
#   ## the plugin will send pings directly.
#   ##
#   ## While the default is "exec" for backwards compatibility, new deployments
#   ## are encouraged to use the "native" method for improved compatibility and
#   ## performance.
#   # method = "exec"
#
#   ## Number of ping packets to send per interval.  Corresponds to the "-c"
#   ## option of the ping command.
#   # count = 1
#
#   ## Time to wait between sending ping packets in seconds.  Operates like the
#   ## "-i" option of the ping command.
#   # ping_interval = 1.0
#
#   ## If set, the time to wait for a ping response in seconds.  Operates like
#   ## the "-W" option of the ping command.
#   # timeout = 1.0
#
#   ## If set, the total ping deadline, in seconds.  Operates like the -w option
#   ## of the ping command.
#   # deadline = 10
#
#   ## Interface or source address to send ping from.  Operates like the -I or -S
#   ## option of the ping command.
#   # interface = ""
#
#   ## Percentiles to calculate. This only works with the native method.
#   # percentiles = [50, 95, 99]
#
#   ## Specify the ping executable binary.
#   # binary = "ping"
#
#   ## Arguments for ping command. When arguments is not empty, the command from
#   ## the binary option will be used and other options (ping_interval, timeout,
#   ## etc) will be ignored.
#   # arguments = ["-c", "3"]
#
#   ## Use only IPv6 addresses when resolving a hostname.
#   # ipv6 = false
#
#   ## Number of data bytes to be sent. Corresponds to the "-s"
#   ## option of the ping command. This only works with the native method.
#   # size = 56


# # Measure postfix queue statistics
# [[inputs.postfix]]
#   ## Postfix queue directory. If not provided, telegraf will try to use
#   ## 'postconf -h queue_directory' to determine it.
#   # queue_directory = "/var/spool/postfix"


# # Read metrics from one or many PowerDNS servers
# [[inputs.powerdns]]
#   ## An array of sockets to gather stats about.
#   ## Specify a path to unix socket.
#   unix_sockets = ["/var/run/pdns.controlsocket"]


# # Read metrics from one or many PowerDNS Recursor servers
# [[inputs.powerdns_recursor]]
#   ## Path to the Recursor control socket.
#   unix_sockets = ["/var/run/pdns_recursor.controlsocket"]
#
#   ## Directory to create receive socket.  This default is likely not writable,
#   ## please reference the full plugin documentation for a recommended setup.
#   # socket_dir = "/var/run/"
#   ## Socket permissions for the receive socket.
#   # socket_mode = "0666"


# # Monitor process cpu and memory usage
# [[inputs.procstat]]
#   ## PID file to monitor process
#   pid_file = "/var/run/nginx.pid"
#   ## executable name (ie, pgrep <exe>)
#   # exe = "nginx"
#   ## pattern as argument for pgrep (ie, pgrep -f <pattern>)
#   # pattern = "nginx"
#   ## user as argument for pgrep (ie, pgrep -u <user>)
#   # user = "nginx"
#   ## Systemd unit name, supports globs when include_systemd_children is set to true
#   # systemd_unit = "nginx.service"
#   # include_systemd_children = false
#   ## CGroup name or path, supports globs
#   # cgroup = "systemd/system.slice/nginx.service"
#
#   ## Windows service name
#   # win_service = ""
#
#   ## override for process_name
#   ## This is optional; default is sourced from /proc/<pid>/status
#   # process_name = "bar"
#
#   ## Field name prefix
#   # prefix = ""
#
#   ## When true add the full cmdline as a tag.
#   # cmdline_tag = false
#
#   ## Mode to use when calculating CPU usage. Can be one of 'solaris' or 'irix'.
#   # mode = "irix"
#
#   ## Add the PID as a tag instead of as a field.  When collecting multiple
#   ## processes with otherwise matching tags this setting should be enabled to
#   ## ensure each process has a unique identity.
#   ##
#   ## Enabling this option may result in a large number of series, especially
#   ## when processes have a short lifetime.
#   # pid_tag = false
#
#   ## Method to use when finding process IDs.  Can be one of 'pgrep', or
#   ## 'native'.  The pgrep finder calls the pgrep executable in the PATH while
#   ## the native finder performs the search directly in a manor dependent on the
#   ## platform.  Default is 'pgrep'
#   # pid_finder = "pgrep"


# # Provides metrics from Proxmox nodes (Proxmox Virtual Environment > 6.2).
# [[inputs.proxmox]]
#   ## API connection configuration. The API token was introduced in Proxmox v6.2. Required permissions for user and token: PVEAuditor role on /.
#   base_url = "https://localhost:8006/api2/json"
#   api_token = "USER@REALM!TOKENID=UUID"
#   ## Node name, defaults to OS hostname
#   # node_name = ""
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   insecure_skip_verify = false
#
#   # HTTP response timeout (default: 5s)
#   response_timeout = "5s"


# # Reads last_run_summary.yaml file and converts to measurements
# [[inputs.puppetagent]]
#   ## Location of puppet last run summary file
#   location = "/var/lib/puppet/state/last_run_summary.yaml"


# # Reads metrics from RabbitMQ servers via the Management Plugin
# [[inputs.rabbitmq]]
#   ## Management Plugin url. (default: http://localhost:15672)
#   # url = "http://localhost:15672"
#   ## Credentials
#   # username = "guest"
#   # password = "guest"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## Optional request timeouts
#   ##
#   ## ResponseHeaderTimeout, if non-zero, specifies the amount of time to wait
#   ## for a server's response headers after fully writing the request.
#   # header_timeout = "3s"
#   ##
#   ## client_timeout specifies a time limit for requests made by this client.
#   ## Includes connection time, any redirects, and reading the response body.
#   # client_timeout = "4s"
#
#   ## A list of nodes to gather as the rabbitmq_node measurement. If not
#   ## specified, metrics for all nodes are gathered.
#   # nodes = ["rabbit@node1", "rabbit@node2"]
#
#   ## A list of exchanges to gather as the rabbitmq_exchange measurement. If not
#   ## specified, metrics for all exchanges are gathered.
#   # exchanges = ["telegraf"]
#
#   ## Metrics to include and exclude. Globs accepted.
#   ## Note that an empty array for both will include all metrics
#   ## Currently the following metrics are supported: "exchange", "federation", "node", "overview", "queue"
#   # metric_include = []
#   # metric_exclude = []
#
#   ## Queues to include and exclude. Globs accepted.
#   ## Note that an empty array for both will include all queues
#   queue_name_include = []
#   queue_name_exclude = []
#
#   ## Federation upstreams include and exclude when gathering the rabbitmq_federation measurement.
#   ## If neither are specified, metrics for all federation upstreams are gathered.
#   ## Federation link metrics will only be gathered for queues and exchanges
#   ## whose non-federation metrics will be collected (e.g a queue excluded
#   ## by the 'queue_name_exclude' option will also be excluded from federation).
#   ## Globs accepted.
#   # federation_upstream_include = ["dataCentre-*"]
#   # federation_upstream_exclude = []


# # Read raindrops stats (raindrops - real-time stats for preforking Rack servers)
# [[inputs.raindrops]]
#   ## An array of raindrops middleware URI to gather stats.
#   urls = ["http://localhost:8080/_raindrops"]


# # Reads metrics from RavenDB servers via the Monitoring Endpoints
# [[inputs.ravendb]]
#   ## Node URL and port that RavenDB is listening on. By default,
#   ## attempts to connect securely over HTTPS, however, if the user
#   ## is running a local unsecure development cluster users can use
#   ## HTTP via a URL like "http://localhost:8080"
#   url = "https://localhost:4433"
#
#   ## RavenDB X509 client certificate setup
#   # tls_cert = "/etc/telegraf/raven.crt"
#   # tls_key = "/etc/telegraf/raven.key"
#
#   ## Optional request timeout
#   ##
#   ## Timeout, specifies the amount of time to wait
#   ## for a server's response headers after fully writing the request and
#   ## time limit for requests made by this client
#   # timeout = "5s"
#
#   ## List of statistics which are collected
#   # At least one is required
#   # Allowed values: server, databases, indexes, collections
#   #
#   # stats_include = ["server", "databases", "indexes", "collections"]
#
#   ## List of db where database stats are collected
#   ## If empty, all db are concerned
#   # db_stats_dbs = []
#
#   ## List of db where index status are collected
#   ## If empty, all indexes from all db are concerned
#   # index_stats_dbs = []
#
#   ## List of db where collection status are collected
#   ## If empty, all collections from all db are concerned
#   # collection_stats_dbs = []


# # Read CPU, Fans, Powersupply and Voltage metrics of hardware server through redfish APIs
# [[inputs.redfish]]
#   ## Server url
#   address = "https://127.0.0.1:5000"
#
#   ## Username, Password for hardware server
#   username = "root"
#   password = "password123456"
#
#   ## ComputerSystemId
#   computer_system_id="2M220100SL"
#
#   ## Amount of time allowed to complete the HTTP request
#   # timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Read metrics from one or many redis servers
# [[inputs.redis]]
#   ## specify servers via a url matching:
#   ##  [protocol://][:password]@address[:port]
#   ##  e.g.
#   ##    tcp://localhost:6379
#   ##    tcp://:password@192.168.99.100
#   ##    unix:///var/run/redis.sock
#   ##
#   ## If no servers are specified, then localhost is used as the host.
#   ## If no port is specified, 6379 is used
#   servers = ["tcp://localhost:6379"]
#
#   ## Optional. Specify redis commands to retrieve values
#   # [[inputs.redis.commands]]
#   #   # The command to run where each argument is a separate element
#   #   command = ["get", "sample-key"]
#   #   # The field to store the result in
#   #   field = "sample-key-value"
#   #   # The type of the result
#   #   # Can be "string", "integer", or "float"
#   #   type = "string"
#
#   ## specify server password
#   # password = "s#cr@t%"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = true


# # Read metrics from one or many redis-sentinel servers
# [[inputs.redis_sentinel]]
#   ## specify servers via a url matching:
#   ##  [protocol://][:password]@address[:port]
#   ##  e.g.
#   ##    tcp://localhost:26379
#   ##    tcp://:password@192.168.99.100
#   ##    unix:///var/run/redis-sentinel.sock
#   ##
#   ## If no servers are specified, then localhost is used as the host.
#   ## If no port is specified, 26379 is used
#   # servers = ["tcp://localhost:26379"]
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = true


# # Read metrics from one or many RethinkDB servers
# [[inputs.rethinkdb]]
#   ## An array of URI to gather stats about. Specify an ip or hostname
#   ## with optional port add password. ie,
#   ##   rethinkdb://user:auth_key@10.10.3.30:28105,
#   ##   rethinkdb://10.10.3.33:18832,
#   ##   10.0.0.1:10000, etc.
#   servers = ["127.0.0.1:28015"]
#   ##
#   ## If you use actual rethinkdb of > 2.3.0 with username/password authorization,
#   ## protocol have to be named "rethinkdb2" - it will use 1_0 H.
#   # servers = ["rethinkdb2://username:password@127.0.0.1:28015"]
#   ##
#   ## If you use older versions of rethinkdb (<2.2) with auth_key, protocol
#   ## have to be named "rethinkdb".
#   # servers = ["rethinkdb://username:auth_key@127.0.0.1:28015"]


# # Read metrics one or many Riak servers
# [[inputs.riak]]
#   # Specify a list of one or more riak http servers
#   servers = ["http://localhost:8098"]


# # Read API usage and limits for a Salesforce organisation
# [[inputs.salesforce]]
#   ## specify your credentials
#   ##
#   username = "your_username"
#   password = "your_password"
#   ##
#   ## (optional) security token
#   # security_token = "your_security_token"
#   ##
#   ## (optional) environment type (sandbox or production)
#   ## default is: production
#   ##
#   # environment = "production"
#   ##
#   ## (optional) API version (default: "39.0")
#   ##
#   # version = "39.0"


# # Monitor sensors, requires lm-sensors package
# [[inputs.sensors]]
#   ## Remove numbers from field names.
#   ## If true, a field name like 'temp1_input' will be changed to 'temp_input'.
#   # remove_numbers = true
#
#   ## Timeout is the maximum amount of time that the sensors command can run.
#   # timeout = "5s"


# # Read metrics from storage devices supporting S.M.A.R.T.
# [[inputs.smart]]
#   ## Optionally specify the path to the smartctl executable
#   # path_smartctl = "/usr/bin/smartctl"
#
#   ## Optionally specify the path to the nvme-cli executable
#   # path_nvme = "/usr/bin/nvme"
#
#   ## Optionally specify if vendor specific attributes should be propagated for NVMe disk case
#   ## ["auto-on"] - automatically find and enable additional vendor specific disk info
#   ## ["vendor1", "vendor2", ...] - e.g. "Intel" enable additional Intel specific disk info
#   # enable_extensions = ["auto-on"]
#
#   ## On most platforms used cli utilities requires root access.
#   ## Setting 'use_sudo' to true will make use of sudo to run smartctl or nvme-cli.
#   ## Sudo must be configured to allow the telegraf user to run smartctl or nvme-cli
#   ## without a password.
#   # use_sudo = false
#
#   ## Skip checking disks in this power mode. Defaults to
#   ## "standby" to not wake up disks that have stopped rotating.
#   ## See --nocheck in the man pages for smartctl.
#   ## smartctl version 5.41 and 5.42 have faulty detection of
#   ## power mode and might require changing this value to
#   ## "never" depending on your disks.
#   # nocheck = "standby"
#
#   ## Gather all returned S.M.A.R.T. attribute metrics and the detailed
#   ## information from each drive into the 'smart_attribute' measurement.
#   # attributes = false
#
#   ## Optionally specify devices to exclude from reporting if disks auto-discovery is performed.
#   # excludes = [ "/dev/pass6" ]
#
#   ## Optionally specify devices and device type, if unset
#   ## a scan (smartctl --scan and smartctl --scan -d nvme) for S.M.A.R.T. devices will be done
#   ## and all found will be included except for the excluded in excludes.
#   # devices = [ "/dev/ada0 -d atacam", "/dev/nvme0"]
#
#   ## Timeout for the cli command to complete.
#   # timeout = "30s"
#
#   ## Optionally call smartctl and nvme-cli with a specific concurrency policy.
#   ## By default, smartctl and nvme-cli are called in separate threads (goroutines) to gather disk attributes.
#   ## Some devices (e.g. disks in RAID arrays) may have access limitations that require sequential reading of
#   ## SMART data - one individual array drive at the time. In such case please set this configuration option
#   ## to "sequential" to get readings for all drives.
#   ## valid options: concurrent, sequential
#   # read_method = "concurrent"


# # Retrieves SNMP values from remote agents
# [[inputs.snmp]]
#   ## Agent addresses to retrieve values from.
#   ##   format:  agents = ["<scheme://><hostname>:<port>"]
#   ##   scheme:  optional, either udp, udp4, udp6, tcp, tcp4, tcp6.
#   ##            default is udp
#   ##   port:    optional
#   ##   example: agents = ["udp://127.0.0.1:161"]
#   ##            agents = ["tcp://127.0.0.1:161"]
#   ##            agents = ["udp4://v4only-snmp-agent"]
#   agents = ["udp://127.0.0.1:161"]
#
#   ## Timeout for each request.
#   # timeout = "5s"
#
#   ## SNMP version; can be 1, 2, or 3.
#   # version = 2
#
#   ## Path to mib files
#   # path = ["/usr/share/snmp/mibs"]
#
#   ## Agent host tag; the tag used to reference the source host
#   # agent_host_tag = "agent_host"
#
#   ## SNMP community string.
#   # community = "public"
#
#   ## Number of retries to attempt.
#   # retries = 3
#
#   ## The GETBULK max-repetitions parameter.
#   # max_repetitions = 10
#
#   ## SNMPv3 authentication and encryption options.
#   ##
#   ## Security Name.
#   # sec_name = "myuser"
#   ## Authentication protocol; one of "MD5", "SHA", "SHA224", "SHA256", "SHA384", "SHA512" or "".
#   # auth_protocol = "MD5"
#   ## Authentication password.
#   # auth_password = "pass"
#   ## Security Level; one of "noAuthNoPriv", "authNoPriv", or "authPriv".
#   # sec_level = "authNoPriv"
#   ## Context Name.
#   # context_name = ""
#   ## Privacy protocol used for encrypted messages; one of "DES", "AES" or "".
#   # priv_protocol = ""
#   ## Privacy password used for encrypted messages.
#   # priv_password = ""
#
#   ## Add fields and tables defining the variables you wish to collect.  This
#   ## example collects the system uptime and interface variables.  Reference the
#   ## full plugin documentation for configuration details.


# # DEPRECATED! PLEASE USE inputs.snmp INSTEAD.
# [[inputs.snmp_legacy]]
#   ## DEPRECATED: The 'snmp_legacy' plugin is deprecated in version 1.0.0, use 'inputs.snmp' instead.
#   ## Use 'oids.txt' file to translate oids to names
#   ## To generate 'oids.txt' you need to run:
#   ##   snmptranslate -m all -Tz -On | sed -e 's/"//g' > /tmp/oids.txt
#   ## Or if you have an other MIB folder with custom MIBs
#   ##   snmptranslate -M /mycustommibfolder -Tz -On -m all | sed -e 's/"//g' > oids.txt
#   snmptranslate_file = "/tmp/oids.txt"
#   [[inputs.snmp.host]]
#     address = "192.168.2.2:161"
#     # SNMP community
#     community = "public" # default public
#     # SNMP version (1, 2 or 3)
#     # Version 3 not supported yet
#     version = 2 # default 2
#     # SNMP response timeout
#     timeout = 2.0 # default 2.0
#     # SNMP request retries
#     retries = 2 # default 2
#     # Which get/bulk do you want to collect for this host
#     collect = ["mybulk", "sysservices", "sysdescr"]
#     # Simple list of OIDs to get, in addition to "collect"
#     get_oids = []
#
#   [[inputs.snmp.host]]
#     address = "192.168.2.3:161"
#     community = "public"
#     version = 2
#     timeout = 2.0
#     retries = 2
#     collect = ["mybulk"]
#     get_oids = [
#         "ifNumber",
#         ".1.3.6.1.2.1.1.3.0",
#     ]
#
#   [[inputs.snmp.get]]
#     name = "ifnumber"
#     oid = "ifNumber"
#
#   [[inputs.snmp.get]]
#     name = "interface_speed"
#     oid = "ifSpeed"
#     instance = "0"
#
#   [[inputs.snmp.get]]
#     name = "sysuptime"
#     oid = ".1.3.6.1.2.1.1.3.0"
#     unit = "second"
#
#   [[inputs.snmp.bulk]]
#     name = "mybulk"
#     max_repetition = 127
#     oid = ".1.3.6.1.2.1.1"
#
#   [[inputs.snmp.bulk]]
#     name = "ifoutoctets"
#     max_repetition = 127
#     oid = "ifOutOctets"
#
#   [[inputs.snmp.host]]
#     address = "192.168.2.13:161"
#     #address = "127.0.0.1:161"
#     community = "public"
#     version = 2
#     timeout = 2.0
#     retries = 2
#     #collect = ["mybulk", "sysservices", "sysdescr", "systype"]
#     collect = ["sysuptime" ]
#     [[inputs.snmp.host.table]]
#       name = "iftable3"
#       include_instances = ["enp5s0", "eth1"]
#
#   # SNMP TABLEs
#   # table without mapping neither subtables
#   [[inputs.snmp.table]]
#     name = "iftable1"
#     oid = ".1.3.6.1.2.1.31.1.1.1"
#
#   # table without mapping but with subtables
#   [[inputs.snmp.table]]
#     name = "iftable2"
#     oid = ".1.3.6.1.2.1.31.1.1.1"
#     sub_tables = [".1.3.6.1.2.1.2.2.1.13"]
#
#   # table with mapping but without subtables
#   [[inputs.snmp.table]]
#     name = "iftable3"
#     oid = ".1.3.6.1.2.1.31.1.1.1"
#     # if empty. get all instances
#     mapping_table = ".1.3.6.1.2.1.31.1.1.1.1"
#     # if empty, get all subtables
#
#   # table with both mapping and subtables
#   [[inputs.snmp.table]]
#     name = "iftable4"
#     oid = ".1.3.6.1.2.1.31.1.1.1"
#     # if empty get all instances
#     mapping_table = ".1.3.6.1.2.1.31.1.1.1.1"
#     # if empty get all subtables
#     # sub_tables could be not "real subtables"
#     sub_tables=[".1.3.6.1.2.1.2.2.1.13", "bytes_recv", "bytes_send"]


# # Gather indicators from established connections, using iproute2's `ss` command.
# [[inputs.socketstat]]
#   ## ss can display information about tcp, udp, raw, unix, packet, dccp and sctp sockets
#   ## List of protocol types to collect
#   # protocols = [ "tcp", "udp" ]
#   ## The default timeout of 1s for ss execution can be overridden here:
#   # timeout = "1s"


# # Read stats from one or more Solr servers or cores
# [[inputs.solr]]
#   ## specify a list of one or more Solr servers
#   servers = ["http://localhost:8983"]
#
#   ## specify a list of one or more Solr cores (default - all)
#   # cores = ["main"]
#
#   ## Optional HTTP Basic Auth Credentials
#   # username = "username"
#   # password = "pa$$word"


# # Gather timeseries from Google Cloud Platform v3 monitoring API
# [[inputs.stackdriver]]
#   ## GCP Project
#   project = "erudite-bloom-151019"
#
#   ## Include timeseries that start with the given metric type.
#   metric_type_prefix_include = [
#     "compute.googleapis.com/",
#   ]
#
#   ## Exclude timeseries that start with the given metric type.
#   # metric_type_prefix_exclude = []
#
#   ## Many metrics are updated once per minute; it is recommended to override
#   ## the agent level interval with a value of 1m or greater.
#   interval = "1m"
#
#   ## Maximum number of API calls to make per second.  The quota for accounts
#   ## varies, it can be viewed on the API dashboard:
#   ##   https://cloud.google.com/monitoring/quotas#quotas_and_limits
#   # rate_limit = 14
#
#   ## The delay and window options control the number of points selected on
#   ## each gather.  When set, metrics are gathered between:
#   ##   start: now() - delay - window
#   ##   end:   now() - delay
#   #
#   ## Collection delay; if set too low metrics may not yet be available.
#   # delay = "5m"
#   #
#   ## If unset, the window will start at 1m and be updated dynamically to span
#   ## the time between calls (approximately the length of the plugin interval).
#   # window = "1m"
#
#   ## TTL for cached list of metric types.  This is the maximum amount of time
#   ## it may take to discover new metrics.
#   # cache_ttl = "1h"
#
#   ## If true, raw bucket counts are collected for distribution value types.
#   ## For a more lightweight collection, you may wish to disable and use
#   ## distribution_aggregation_aligners instead.
#   # gather_raw_distribution_buckets = true
#
#   ## Aggregate functions to be used for metrics whose value type is
#   ## distribution.  These aggregate values are recorded in in addition to raw
#   ## bucket counts; if they are enabled.
#   ##
#   ## For a list of aligner strings see:
#   ##   https://cloud.google.com/monitoring/api/ref_v3/rpc/google.monitoring.v3#aligner
#   # distribution_aggregation_aligners = [
#   # 	"ALIGN_PERCENTILE_99",
#   # 	"ALIGN_PERCENTILE_95",
#   # 	"ALIGN_PERCENTILE_50",
#   # ]
#
#   ## Filters can be added to reduce the number of time series matched.  All
#   ## functions are supported: starts_with, ends_with, has_substring, and
#   ## one_of.  Only the '=' operator is supported.
#   ##
#   ## The logical operators when combining filters are defined statically using
#   ## the following values:
#   ##   filter ::= <resource_labels> {AND <metric_labels>}
#   ##   resource_labels ::= <resource_labels> {OR <resource_label>}
#   ##   metric_labels ::= <metric_labels> {OR <metric_label>}
#   ##
#   ## For more details, see https://cloud.google.com/monitoring/api/v3/filters
#   #
#   ## Resource labels refine the time series selection with the following expression:
#   ##   resource.labels.<key> = <value>
#   # [[inputs.stackdriver.filter.resource_labels]]
#   #   key = "instance_name"
#   #   value = 'starts_with("localhost")'
#   #
#   ## Metric labels refine the time series selection with the following expression:
#   ##   metric.labels.<key> = <value>
#   #  [[inputs.stackdriver.filter.metric_labels]]
#   #  	 key = "device_name"
#   #  	 value = 'one_of("sda", "sdb")'


# # Get synproxy counter statistics from procfs
# [[inputs.synproxy]]
#   # no configuration


# # Sysstat metrics collector
# [[inputs.sysstat]]
#   ## Path to the sadc command.
#   #
#   ## Common Defaults:
#   ##   Debian/Ubuntu: /usr/lib/sysstat/sadc
#   ##   Arch:          /usr/lib/sa/sadc
#   ##   RHEL/CentOS:   /usr/lib64/sa/sadc
#   sadc_path = "/usr/lib/sa/sadc" # required
#
#   ## Path to the sadf command, if it is not in PATH
#   # sadf_path = "/usr/bin/sadf"
#
#   ## Activities is a list of activities, that are passed as argument to the
#   ## sadc collector utility (e.g: DISK, SNMP etc...)
#   ## The more activities that are added, the more data is collected.
#   # activities = ["DISK"]
#
#   ## Group metrics to measurements.
#   ##
#   ## If group is false each metric will be prefixed with a description
#   ## and represents itself a measurement.
#   ##
#   ## If Group is true, corresponding metrics are grouped to a single measurement.
#   # group = true
#
#   ## Options for the sadf command. The values on the left represent the sadf
#   ## options and the values on the right their description (which are used for
#   ## grouping and prefixing metrics).
#   ##
#   ## Run 'sar -h' or 'man sar' to find out the supported options for your
#   ## sysstat version.
#   [inputs.sysstat.options]
#     -C = "cpu"
#     -B = "paging"
#     -b = "io"
#     -d = "disk"             # requires DISK activity
#     "-n ALL" = "network"
#     "-P ALL" = "per_cpu"
#     -q = "queue"
#     -R = "mem"
#     -r = "mem_util"
#     -S = "swap_util"
#     -u = "cpu_util"
#     -v = "inode"
#     -W = "swap"
#     -w = "task"
#   #  -H = "hugepages"        # only available for newer linux distributions
#   #  "-I ALL" = "interrupts" # requires INT activity
#
#   ## Device tags can be used to add additional tags for devices.
#   ## For example the configuration below adds a tag vg with value rootvg for
#   ## all metrics with sda devices.
#   # [[inputs.sysstat.device_tags.sda]]
#   #  vg = "rootvg"


# # Gather systemd units state
# [[inputs.systemd_units]]
#   ## Set timeout for systemctl execution
#   # timeout = "1s"
#   #
#   ## Filter for a specific unit type, default is "service", other possible
#   ## values are "socket", "target", "device", "mount", "automount", "swap",
#   ## "timer", "path", "slice" and "scope ":
#   # unittype = "service"
#   #
#   ## Filter for a specific pattern, default is "" (i.e. all), other possible
#   ## values are valid pattern for systemctl, e.g. "a*" for all units with
#   ## names starting with "a"
#   # pattern = ""
#   ## pattern = "telegraf* influxdb*"
#   ## pattern = "a*"


# # Reads metrics from a Teamspeak 3 Server via ServerQuery
# [[inputs.teamspeak]]
#   ## Server address for Teamspeak 3 ServerQuery
#   # server = "127.0.0.1:10011"
#   ## Username for ServerQuery
#   username = "serverqueryuser"
#   ## Password for ServerQuery
#   password = "secret"
#   ## Array of virtual servers
#   # virtual_servers = [1]


# # Read metrics about temperature
# [[inputs.temp]]
#   # no configuration


# # Read Tengine's basic status information (ngx_http_reqstat_module)
# [[inputs.tengine]]
#   # An array of Tengine reqstat module URI to gather stats.
#   urls = ["http://127.0.0.1/us"]
#
#   # HTTP response timeout (default: 5s)
#   # response_timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.cer"
#   # tls_key = "/etc/telegraf/key.key"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Gather metrics from the Tomcat server status page.
# [[inputs.tomcat]]
#   ## URL of the Tomcat server status
#   # url = "http://127.0.0.1:8080/manager/status/all?XML=true"
#
#   ## HTTP Basic Auth Credentials
#   # username = "tomcat"
#   # password = "s3cret"
#
#   ## Request timeout
#   # timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Inserts sine and cosine waves for demonstration purposes
# [[inputs.trig]]
#   ## Set the amplitude
#   amplitude = 10.0


# # Read Twemproxy stats data
# [[inputs.twemproxy]]
#   ## Twemproxy stats address and port (no scheme)
#   addr = "localhost:22222"
#   ## Monitor pool name
#   pools = ["redis_pool", "mc_pool"]


# # A plugin to collect stats from the Unbound DNS resolver
# [[inputs.unbound]]
#   ## Address of server to connect to, read from unbound conf default, optionally ':port'
#   ## Will lookup IP if given a hostname
#   server = "127.0.0.1:8953"
#
#   ## If running as a restricted user you can prepend sudo for additional access:
#   # use_sudo = false
#
#   ## The default location of the unbound-control binary can be overridden with:
#   # binary = "/usr/sbin/unbound-control"
#
#   ## The default location of the unbound config file can be overridden with:
#   # config_file = "/etc/unbound/unbound.conf"
#
#   ## The default timeout of 1s can be overridden with:
#   # timeout = "1s"
#
#   ## When set to true, thread metrics are tagged with the thread id.
#   ##
#   ## The default is false for backwards compatibility, and will be changed to
#   ## true in a future version.  It is recommended to set to true on new
#   ## deployments.
#   thread_as_tag = false


# # Read uWSGI metrics.
# [[inputs.uwsgi]]
#   ## List with urls of uWSGI Stats servers. URL must match pattern:
#   ## scheme://address[:port]
#   ##
#   ## For example:
#   ## servers = ["tcp://localhost:5050", "http://localhost:1717", "unix:///tmp/statsock"]
#   servers = ["tcp://127.0.0.1:1717"]
#
#   ## General connection timeout
#   # timeout = "5s"


# # A plugin to collect stats from Varnish HTTP Cache
# [[inputs.varnish]]
#   ## If running as a restricted user you can prepend sudo for additional access:
#   #use_sudo = false
#
#   ## The default location of the varnishstat binary can be overridden with:
#   binary = "/usr/bin/varnishstat"
#
#   ## Additional custom arguments for the varnishstat command
#   # binary_args = ["-f", "MAIN.*"]
#
#   ## The default location of the varnishadm binary can be overriden with:
#   adm_binary = "/usr/bin/varnishadm"
#
#   ## Custom arguments for the varnishadm command
#   # adm_binary_args = [""]
#
#   ## Metric version defaults to metric_version=1, use metric_version=2 for removal of nonactive vcls.
#   metric_version = 1
#
#   ## Additional regexps to override builtin conversion of varnish metrics into telegraf metrics.
#   ## Regexp group "_vcl" is used for extracting the VCL name. Metrics that contains nonactive VCL's are skipped.
#   ## Regexp group "_field" overrides field name. Other named regexp groups are used as tags.
#   # regexps = ['XCNT\.(?P<_vcl>[\w\-]*)\.(?P<group>[\w\-.+]*)\.(?P<_field>[\w\-.+]*)\.val']
#
#   ## By default, telegraf gather stats for 3 metric points.
#   ## Setting stats will override the defaults shown below.
#   ## Glob matching can be used, ie, stats = ["MAIN.*"]
#   ## stats may also be set to ["*"], which will collect all stats
#   stats = ["MAIN.cache_hit", "MAIN.cache_miss", "MAIN.uptime"]
#
#   ## Optional name for the varnish instance (or working directory) to query
#   ## Usually append after -n in varnish cli
#   # instance_name = instanceName
#
#   ## Timeout for varnishstat command
#   # timeout = "1s"


# # Read metrics from the Vault API
# [[inputs.vault]]
#   ## URL for the Vault agent
#   # url = "http://127.0.0.1:8200"
#
#   ## Use Vault token for authorization.
#   ## Vault token configuration is mandatory.
#   ## If both are empty or both are set, an error is thrown.
#   # token_file = "/path/to/auth/token"
#   ## OR
#   token = "s.CDDrgg5zPv5ssI0Z2P4qxJj2"
#
#   ## Set response_timeout (default 5 seconds)
#   # response_timeout = "5s"
#
#   ## Optional TLS Config
#   # tls_ca = /path/to/cafile
#   # tls_cert = /path/to/certfile
#   # tls_key = /path/to/keyfile


# # Collect Wireguard server interface and peer statistics
# [[inputs.wireguard]]
#   ## Optional list of Wireguard device/interface names to query.
#   ## If omitted, all Wireguard interfaces are queried.
#   # devices = ["wg0"]


# # Monitor wifi signal strength and quality
# [[inputs.wireless]]
#   ## Sets 'proc' directory path
#   ## If not specified, then default is /proc
#   # host_proc = "/proc"


# # Reads metrics from a SSL certificate
# [[inputs.x509_cert]]
#   ## List certificate sources
#   ## Prefix your entry with 'file://' if you intend to use relative paths
#   sources = ["tcp://example.org:443", "https://influxdata.com:443",
#             "udp://127.0.0.1:4433", "/etc/ssl/certs/ssl-cert-snakeoil.pem",
#             "/etc/mycerts/*.mydomain.org.pem", "file:///path/to/*.pem"]
#
#   ## Timeout for SSL connection
#   # timeout = "5s"
#
#   ## Pass a different name into the TLS request (Server Name Indication)
#   ##   example: server_name = "myhost.example.org"
#   # server_name = ""
#
#   ## Don't include root or intermediate certificates in output
#   # exclude_root_certs = false
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"


# # Gathers Metrics From a Dell EMC XtremIO Storage Array's V3 API
# [[inputs.xtremio]]
#   ## XtremIO User Interface Endpoint
#   url = "https://xtremio.example.com/" # required
#
#   ## Credentials
#   username = "user1"
#   password = "pass123"
#
#   ## Metrics to collect from the XtremIO
#   # collectors = ["bbus","clusters","ssds","volumes","xms"]
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use SSL but skip chain & host verification
#   # insecure_skip_verify = false


# # Read metrics of ZFS from arcstats, zfetchstats, vdev_cache_stats, pools and datasets
# [[inputs.zfs]]
#   ## ZFS kstat path. Ignored on FreeBSD
#   ## If not specified, then default is:
#   # kstatPath = "/proc/spl/kstat/zfs"
#
#   ## By default, telegraf gather all zfs stats
#   ## If not specified, then default is:
#   # kstatMetrics = ["arcstats", "zfetchstats", "vdev_cache_stats"]
#   ## For Linux, the default is:
#   # kstatMetrics = ["abdstats", "arcstats", "dnodestats", "dbufcachestats",
#   #   "dmu_tx", "fm", "vdev_mirror_stats", "zfetchstats", "zil"]
#   ## By default, don't gather zpool stats
#   # poolMetrics = false
#   ## By default, don't gather zdataset stats
#   # datasetMetrics = false


# # Reads 'mntr' stats from one or many zookeeper servers
# [[inputs.zookeeper]]
#   ## An array of address to gather stats about. Specify an ip or hostname
#   ## with port. ie localhost:2181, 10.0.0.1:2181, etc.
#
#   ## If no servers are specified, then localhost is used as the host.
#   ## If no port is specified, 2181 is used
#   servers = [":2181"]
#
#   ## Timeout for metric collections from all servers.  Minimum timeout is "1s".
#   # timeout = "5s"
#
#   ## Optional TLS Config
#   # enable_tls = true
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## If false, skip chain & host verification
#   # insecure_skip_verify = true


###############################################################################
#                            SERVICE INPUT PLUGINS                            #
###############################################################################


# # Pull Metric Statistics from Aliyun CMS
# [[inputs.aliyuncms]]
#   ## Aliyun Credentials
#   ## Credentials are loaded in the following order
#   ## 1) Ram RoleArn credential
#   ## 2) AccessKey STS token credential
#   ## 3) AccessKey credential
#   ## 4) Ecs Ram Role credential
#   ## 5) RSA keypair credential
#   ## 6) Environment variables credential
#   ## 7) Instance metadata credential
#
#   # access_key_id = ""
#   # access_key_secret = ""
#   # access_key_sts_token = ""
#   # role_arn = ""
#   # role_session_name = ""
#   # private_key = ""
#   # public_key_id = ""
#   # role_name = ""
#
#   ## Specify the ali cloud region list to be queried for metrics and objects discovery
#   ## If not set, all supported regions (see below) would be covered, it can provide a significant load on API, so the recommendation here
#   ## is to limit the list as much as possible. Allowed values: https://www.alibabacloud.com/help/zh/doc-detail/40654.htm
#   ## Default supported regions are:
#   ## 21 items: cn-qingdao,cn-beijing,cn-zhangjiakou,cn-huhehaote,cn-hangzhou,cn-shanghai,cn-shenzhen,
#   ##           cn-heyuan,cn-chengdu,cn-hongkong,ap-southeast-1,ap-southeast-2,ap-southeast-3,ap-southeast-5,
#   ##           ap-south-1,ap-northeast-1,us-west-1,us-east-1,eu-central-1,eu-west-1,me-east-1
#   ##
#   ## From discovery perspective it set the scope for object discovery, the discovered info can be used to enrich
#   ## the metrics with objects attributes/tags. Discovery is supported not for all projects (if not supported, then
#   ## it will be reported on the start - for example for 'acs_cdn' project:
#   ## 'E! [inputs.aliyuncms] Discovery tool is not activated: no discovery support for project "acs_cdn"' )
#   ## Currently, discovery supported for the following projects:
#   ## - acs_ecs_dashboard
#   ## - acs_rds_dashboard
#   ## - acs_slb_dashboard
#   ## - acs_vpc_eip
#   regions = ["cn-hongkong"]
#
#   # The minimum period for AliyunCMS metrics is 1 minute (60s). However not all
#   # metrics are made available to the 1 minute period. Some are collected at
#   # 3 minute, 5 minute, or larger intervals.
#   # See: https://help.aliyun.com/document_detail/51936.html?spm=a2c4g.11186623.2.18.2bc1750eeOw1Pv
#   # Note that if a period is configured that is smaller than the minimum for a
#   # particular metric, that metric will not be returned by the Aliyun OpenAPI
#   # and will not be collected by Telegraf.
#   #
#   ## Requested AliyunCMS aggregation Period (required - must be a multiple of 60s)
#   period = "5m"
#
#   ## Collection Delay (required - must account for metrics availability via AliyunCMS API)
#   delay = "1m"
#
#   ## Recommended: use metric 'interval' that is a multiple of 'period' to avoid
#   ## gaps or overlap in pulled data
#   interval = "5m"
#
#   ## Metric Statistic Project (required)
#   project = "acs_slb_dashboard"
#
#   ## Maximum requests per second, default value is 200
#   ratelimit = 200
#
#   ## How often the discovery API call executed (default 1m)
#   #discovery_interval = "1m"
#
#   ## Metrics to Pull (Required)
#   [[inputs.aliyuncms.metrics]]
#   ## Metrics names to be requested,
#   ## described here (per project): https://help.aliyun.com/document_detail/28619.html?spm=a2c4g.11186623.6.690.1938ad41wg8QSq
#   names = ["InstanceActiveConnection", "InstanceNewConnection"]
#
#   ## Dimension filters for Metric (these are optional).
#   ## This allows to get additional metric dimension. If dimension is not specified it can be returned or
#   ## the data can be aggregated - it depends on particular metric, you can find details here: https://help.aliyun.com/document_detail/28619.html?spm=a2c4g.11186623.6.690.1938ad41wg8QSq
#   ##
#   ## Note, that by default dimension filter includes the list of discovered objects in scope (if discovery is enabled)
#   ## Values specified here would be added into the list of discovered objects.
#   ## You can specify either single dimension:
#   #dimensions = '{"instanceId": "p-example"}'
#
#   ## Or you can specify several dimensions at once:
#   #dimensions = '[{"instanceId": "p-example"},{"instanceId": "q-example"}]'
#
#   ## Enrichment tags, can be added from discovery (if supported)
#   ## Notation is <measurement_tag_name>:<JMES query path (https://jmespath.org/tutorial.html)>
#   ## To figure out which fields are available, consult the Describe<ObjectType> API per project.
#   ## For example, for SLB: https://api.aliyun.com/#/?product=Slb&version=2014-05-15&api=DescribeLoadBalancers&params={}&tab=MOCK&lang=GO
#   #tag_query_path = [
#   #    "address:Address",
#   #    "name:LoadBalancerName",
#   #    "cluster_owner:Tags.Tag[?TagKey=='cs.cluster.name'].TagValue | [0]"
#   #    ]
#   ## The following tags added by default: regionId (if discovery enabled), userId, instanceId.
#
#   ## Allow metrics without discovery data, if discovery is enabled. If set to true, then metric without discovery
#   ## data would be emitted, otherwise dropped. This cane be of help, in case debugging dimension filters, or partial coverage
#   ## of discovery scope vs monitoring scope
#   #allow_dps_without_discovery = false


# # AMQP consumer plugin
# [[inputs.amqp_consumer]]
#   ## Brokers to consume from.  If multiple brokers are specified a random broker
#   ## will be selected anytime a connection is established.  This can be
#   ## helpful for load balancing when not using a dedicated load balancer.
#   brokers = ["amqp://localhost:5672/influxdb"]
#
#   ## Authentication credentials for the PLAIN auth_method.
#   # username = ""
#   # password = ""
#
#   ## Name of the exchange to declare.  If unset, no exchange will be declared.
#   exchange = "telegraf"
#
#   ## Exchange type; common types are "direct", "fanout", "topic", "header", "x-consistent-hash".
#   # exchange_type = "topic"
#
#   ## If true, exchange will be passively declared.
#   # exchange_passive = false
#
#   ## Exchange durability can be either "transient" or "durable".
#   # exchange_durability = "durable"
#
#   ## Additional exchange arguments.
#   # exchange_arguments = { }
#   # exchange_arguments = {"hash_property" = "timestamp"}
#
#   ## AMQP queue name.
#   queue = "telegraf"
#
#   ## AMQP queue durability can be "transient" or "durable".
#   queue_durability = "durable"
#
#   ## If true, queue will be passively declared.
#   # queue_passive = false
#
#   ## A binding between the exchange and queue using this binding key is
#   ## created.  If unset, no binding is created.
#   binding_key = "#"
#
#   ## Maximum number of messages server should give to the worker.
#   # prefetch_count = 50
#
#   ## Maximum messages to read from the broker that have not been written by an
#   ## output.  For best throughput set based on the number of metrics within
#   ## each message and the size of the output's metric_batch_size.
#   ##
#   ## For example, if each message from the queue contains 10 metrics and the
#   ## output metric_batch_size is 1000, setting this to 100 will ensure that a
#   ## full batch is collected and the write is triggered immediately without
#   ## waiting until the next flush_interval.
#   # max_undelivered_messages = 1000
#
#   ## Auth method. PLAIN and EXTERNAL are supported
#   ## Using EXTERNAL requires enabling the rabbitmq_auth_mechanism_ssl plugin as
#   ## described here: https://www.rabbitmq.com/plugins.html
#   # auth_method = "PLAIN"
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## Content encoding for message payloads, can be set to "gzip" to or
#   ## "identity" to apply no encoding.
#   # content_encoding = "identity"
#
#   ## Data format to consume.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   data_format = "influx"


# # Read Cassandra metrics through Jolokia
# [[inputs.cassandra]]
#   ## DEPRECATED: The 'cassandra' plugin is deprecated in version 1.7.0, use 'inputs.jolokia2' with the 'cassandra.conf' example configuration instead.
#   ## DEPRECATED: The cassandra plugin has been deprecated.  Please use the
#   ## jolokia2 plugin instead.
#   ##
#   ## see https://github.com/influxdata/telegraf/tree/master/plugins/inputs/jolokia2
#
#   context = "/jolokia/read"
#   ## List of cassandra servers exposing jolokia read service
#   servers = ["myuser:mypassword@10.10.10.1:8778","10.10.10.2:8778",":8778"]
#   ## List of metrics collected on above servers
#   ## Each metric consists of a jmx path.
#   ## This will collect all heap memory usage metrics from the jvm and
#   ## ReadLatency metrics for all keyspaces and tables.
#   ## "type=Table" in the query works with Cassandra3.0. Older versions might
#   ## need to use "type=ColumnFamily"
#   metrics  = [
#     "/java.lang:type=Memory/HeapMemoryUsage",
#     "/org.apache.cassandra.metrics:type=Table,keyspace=*,scope=*,name=ReadLatency"
#   ]


# # Cisco model-driven telemetry (MDT) input plugin for IOS XR, IOS XE and NX-OS platforms
# [[inputs.cisco_telemetry_mdt]]
#  ## Telemetry transport can be "tcp" or "grpc".  TLS is only supported when
#  ## using the grpc transport.
#  transport = "grpc"
#
#  ## Address and port to host telemetry listener
#  service_address = ":57000"
#
#  ## Enable TLS; grpc transport only.
#  # tls_cert = "/etc/telegraf/cert.pem"
#  # tls_key = "/etc/telegraf/key.pem"
#
#  ## Enable TLS client authentication and define allowed CA certificates; grpc
#  ##  transport only.
#  # tls_allowed_cacerts = ["/etc/telegraf/clientca.pem"]
#
#  ## Define (for certain nested telemetry measurements with embedded tags) which fields are tags
#  # embedded_tags = ["Cisco-IOS-XR-qos-ma-oper:qos/interface-table/interface/input/service-policy-names/service-policy-instance/statistics/class-stats/class-name"]
#
#  ## Define aliases to map telemetry encoding paths to simple measurement names
#  [inputs.cisco_telemetry_mdt.aliases]
#    ifstats = "ietf-interfaces:interfaces-state/interface/statistics"
#  ##Define Property Xformation, please refer README and https://pubhub.devnetcloud.com/media/dme-docs-9-3-3/docs/appendix/ for Model details.
#  [inputs.cisco_telemetry_mdt.dmes]
#    ModTs = "ignore"
#    CreateTs = "ignore"


# # Read metrics from one or many ClickHouse servers
# [[inputs.clickhouse]]
#   ## Username for authorization on ClickHouse server
#   ## example: username = "default"
#   username = "default"
#
#   ## Password for authorization on ClickHouse server
#   ## example: password = "super_secret"
#
#   ## HTTP(s) timeout while getting metrics values
#   ## The timeout includes connection time, any redirects, and reading the response body.
#   ##   example: timeout = 1s
#   # timeout = 5s
#
#   ## List of servers for metrics scraping
#   ## metrics scrape via HTTP(s) clickhouse interface
#   ## https://clickhouse.tech/docs/en/interfaces/http/
#   ##    example: servers = ["http://127.0.0.1:8123","https://custom-server.mdb.yandexcloud.net"]
#   servers         = ["http://127.0.0.1:8123"]
#
#   ## If "auto_discovery"" is "true" plugin tries to connect to all servers available in the cluster
#   ## with using same "user:password" described in "user" and "password" parameters
#   ## and get this server hostname list from "system.clusters" table
#   ## see
#   ## - https://clickhouse.tech/docs/en/operations/system_tables/#system-clusters
#   ## - https://clickhouse.tech/docs/en/operations/server_settings/settings/#server_settings_remote_servers
#   ## - https://clickhouse.tech/docs/en/operations/table_engines/distributed/
#   ## - https://clickhouse.tech/docs/en/operations/table_engines/replication/#creating-replicated-tables
#   ##    example: auto_discovery = false
#   # auto_discovery = true
#
#   ## Filter cluster names in "system.clusters" when "auto_discovery" is "true"
#   ## when this filter present then "WHERE cluster IN (...)" filter will apply
#   ## please use only full cluster names here, regexp and glob filters is not allowed
#   ## for "/etc/clickhouse-server/config.d/remote.xml"
#   ## <yandex>
#   ##  <remote_servers>
#   ##    <my-own-cluster>
#   ##        <shard>
#   ##          <replica><host>clickhouse-ru-1.local</host><port>9000</port></replica>
#   ##          <replica><host>clickhouse-ru-2.local</host><port>9000</port></replica>
#   ##        </shard>
#   ##        <shard>
#   ##          <replica><host>clickhouse-eu-1.local</host><port>9000</port></replica>
#   ##          <replica><host>clickhouse-eu-2.local</host><port>9000</port></replica>
#   ##        </shard>
#   ##    </my-onw-cluster>
#   ##  </remote_servers>
#   ##
#   ## </yandex>
#   ##
#   ## example: cluster_include = ["my-own-cluster"]
#   # cluster_include = []
#
#   ## Filter cluster names in "system.clusters" when "auto_discovery" is "true"
#   ## when this filter present then "WHERE cluster NOT IN (...)" filter will apply
#   ##    example: cluster_exclude = ["my-internal-not-discovered-cluster"]
#   # cluster_exclude = []
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Read metrics from Google PubSub
# [[inputs.cloud_pubsub]]
#   ## Required. Name of Google Cloud Platform (GCP) Project that owns
#   ## the given PubSub subscription.
#   project = "my-project"
#
#   ## Required. Name of PubSub subscription to ingest metrics from.
#   subscription = "my-subscription"
#
#   ## Required. Data format to consume.
#   ## Each data format has its own unique set of configuration options.
#   ## Read more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   data_format = "influx"
#
#   ## Optional. Filepath for GCP credentials JSON file to authorize calls to
#   ## PubSub APIs. If not set explicitly, Telegraf will attempt to use
#   ## Application Default Credentials, which is preferred.
#   # credentials_file = "path/to/my/creds.json"
#
#   ## Optional. Number of seconds to wait before attempting to restart the
#   ## PubSub subscription receiver after an unexpected error.
#   ## If the streaming pull for a PubSub Subscription fails (receiver),
#   ## the agent attempts to restart receiving messages after this many seconds.
#   # retry_delay_seconds = 5
#
#   ## Optional. Maximum byte length of a message to consume.
#   ## Larger messages are dropped with an error. If less than 0 or unspecified,
#   ## treated as no limit.
#   # max_message_len = 1000000
#
#   ## Optional. Maximum messages to read from PubSub that have not been written
#   ## to an output. Defaults to 1000.
#   ## For best throughput set based on the number of metrics within
#   ## each message and the size of the output's metric_batch_size.
#   ##
#   ## For example, if each message contains 10 metrics and the output
#   ## metric_batch_size is 1000, setting this to 100 will ensure that a
#   ## full batch is collected and the write is triggered immediately without
#   ## waiting until the next flush_interval.
#   # max_undelivered_messages = 1000
#
#   ## The following are optional Subscription ReceiveSettings in PubSub.
#   ## Read more about these values:
#   ## https://godoc.org/cloud.google.com/go/pubsub#ReceiveSettings
#
#   ## Optional. Maximum number of seconds for which a PubSub subscription
#   ## should auto-extend the PubSub ACK deadline for each message. If less than
#   ## 0, auto-extension is disabled.
#   # max_extension = 0
#
#   ## Optional. Maximum number of unprocessed messages in PubSub
#   ## (unacknowledged but not yet expired in PubSub).
#   ## A value of 0 is treated as the default PubSub value.
#   ## Negative values will be treated as unlimited.
#   # max_outstanding_messages = 0
#
#   ## Optional. Maximum size in bytes of unprocessed messages in PubSub
#   ## (unacknowledged but not yet expired in PubSub).
#   ## A value of 0 is treated as the default PubSub value.
#   ## Negative values will be treated as unlimited.
#   # max_outstanding_bytes = 0
#
#   ## Optional. Max number of goroutines a PubSub Subscription receiver can spawn
#   ## to pull messages from PubSub concurrently. This limit applies to each
#   ## subscription separately and is treated as the PubSub default if less than
#   ## 1. Note this setting does not limit the number of messages that can be
#   ## processed concurrently (use "max_outstanding_messages" instead).
#   # max_receiver_go_routines = 0
#
#   ## Optional. If true, Telegraf will attempt to base64 decode the
#   ## PubSub message data before parsing
#   # base64_data = false


# # Google Cloud Pub/Sub Push HTTP listener
# [[inputs.cloud_pubsub_push]]
#   ## Address and port to host HTTP listener on
#   service_address = ":8080"
#
#   ## Application secret to verify messages originate from Cloud Pub/Sub
#   # token = ""
#
#   ## Path to listen to.
#   # path = "/"
#
#   ## Maximum duration before timing out read of the request
#   # read_timeout = "10s"
#   ## Maximum duration before timing out write of the response. This should be set to a value
#   ## large enough that you can send at least 'metric_batch_size' number of messages within the
#   ## duration.
#   # write_timeout = "10s"
#
#   ## Maximum allowed http request body size in bytes.
#   ## 0 means to use the default of 524,288,00 bytes (500 mebibytes)
#   # max_body_size = "500MB"
#
#   ## Whether to add the pubsub metadata, such as message attributes and subscription as a tag.
#   # add_meta = false
#
#   ## Optional. Maximum messages to read from PubSub that have not been written
#   ## to an output. Defaults to 1000.
#   ## For best throughput set based on the number of metrics within
#   ## each message and the size of the output's metric_batch_size.
#   ##
#   ## For example, if each message contains 10 metrics and the output
#   ## metric_batch_size is 1000, setting this to 100 will ensure that a
#   ## full batch is collected and the write is triggered immediately without
#   ## waiting until the next flush_interval.
#   # max_undelivered_messages = 1000
#
#   ## Set one or more allowed client CA certificate file names to
#   ## enable mutually authenticated TLS connections
#   # tls_allowed_cacerts = ["/etc/telegraf/clientca.pem"]
#
#   ## Add service certificate and key
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#
#   ## Data format to consume.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   data_format = "influx"


# # Ingests files in a directory and then moves them to a target directory.
# [[inputs.directory_monitor]]
#   ## The directory to monitor and read files from.
#   directory = ""
#   #
#   ## The directory to move finished files to.
#   finished_directory = ""
#   #
#   ## The directory to move files to upon file error.
#   ## If not provided, erroring files will stay in the monitored directory.
#   # error_directory = ""
#   #
#   ## The amount of time a file is allowed to sit in the directory before it is picked up.
#   ## This time can generally be low but if you choose to have a very large file written to the directory and it's potentially slow,
#   ## set this higher so that the plugin will wait until the file is fully copied to the directory.
#   # directory_duration_threshold = "50ms"
#   #
#   ## A list of the only file names to monitor, if necessary. Supports regex. If left blank, all files are ingested.
#   # files_to_monitor = ["^.*\.csv"]
#   #
#   ## A list of files to ignore, if necessary. Supports regex.
#   # files_to_ignore = [".DS_Store"]
#   #
#   ## Maximum lines of the file to process that have not yet be written by the
#   ## output. For best throughput set to the size of the output's metric_buffer_limit.
#   ## Warning: setting this number higher than the output's metric_buffer_limit can cause dropped metrics.
#   # max_buffered_metrics = 10000
#   #
#   ## The maximum amount of file paths to queue up for processing at once, before waiting until files are processed to find more files.
#   ## Lowering this value will result in *slightly* less memory use, with a potential sacrifice in speed efficiency, if absolutely necessary.
#   #	file_queue_size = 100000
#   #
#   ## Name a tag containing the name of the file the data was parsed from.  Leave empty
#   ## to disable. Cautious when file name variation is high, this can increase the cardinality
#   ## significantly. Read more about cardinality here:
#   ## https://docs.influxdata.com/influxdb/cloud/reference/glossary/#series-cardinality
#   # file_tag = ""
#   #
#   ## The dataformat to be read from the files.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   ## NOTE: We currently only support parsing newline-delimited JSON. See the format here: https://github.com/ndjson/ndjson-spec
#   data_format = "influx"


# # Read logging output from the Docker engine
# [[inputs.docker_log]]
#   ## Docker Endpoint
#   ##   To use TCP, set endpoint = "tcp://[ip]:[port]"
#   ##   To use environment variables (ie, docker-machine), set endpoint = "ENV"
#   # endpoint = "unix:///var/run/docker.sock"
#
#   ## When true, container logs are read from the beginning; otherwise
#   ## reading begins at the end of the log.
#   # from_beginning = false
#
#   ## Timeout for Docker API calls.
#   # timeout = "5s"
#
#   ## Containers to include and exclude. Globs accepted.
#   ## Note that an empty array for both will include all containers
#   # container_name_include = []
#   # container_name_exclude = []
#
#   ## Container states to include and exclude. Globs accepted.
#   ## When empty only containers in the "running" state will be captured.
#   # container_state_include = []
#   # container_state_exclude = []
#
#   ## docker labels to include and exclude as tags.  Globs accepted.
#   ## Note that an empty array for both will include all labels as tags
#   # docker_label_include = []
#   # docker_label_exclude = []
#
#   ## Set the source tag for the metrics to the container ID hostname, eg first 12 chars
#   source_tag = false
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # Azure Event Hubs service input plugin
# [[inputs.eventhub_consumer]]
#   ## The default behavior is to create a new Event Hub client from environment variables.
#   ## This requires one of the following sets of environment variables to be set:
#   ##
#   ## 1) Expected Environment Variables:
#   ##    - "EVENTHUB_CONNECTION_STRING"
#   ##
#   ## 2) Expected Environment Variables:
#   ##    - "EVENTHUB_NAMESPACE"
#   ##    - "EVENTHUB_NAME"
#   ##    - "EVENTHUB_KEY_NAME"
#   ##    - "EVENTHUB_KEY_VALUE"
#
#   ## 3) Expected Environment Variables:
#   ##    - "EVENTHUB_NAMESPACE"
#   ##    - "EVENTHUB_NAME"
#   ##    - "AZURE_TENANT_ID"
#   ##    - "AZURE_CLIENT_ID"
#   ##    - "AZURE_CLIENT_SECRET"
#
#   ## Uncommenting the option below will create an Event Hub client based solely on the connection string.
#   ## This can either be the associated environment variable or hard coded directly.
#   ## If this option is uncommented, environment variables will be ignored.
#   ## Connection string should contain EventHubName (EntityPath)
#   # connection_string = ""
#
#   ## Set persistence directory to a valid folder to use a file persister instead of an in-memory persister
#   # persistence_dir = ""
#
#   ## Change the default consumer group
#   # consumer_group = ""
#
#   ## By default the event hub receives all messages present on the broker, alternative modes can be set below.
#   ## The timestamp should be in https://github.com/toml-lang/toml#offset-date-time format (RFC 3339).
#   ## The 3 options below only apply if no valid persister is read from memory or file (e.g. first run).
#   # from_timestamp =
#   # latest = true
#
#   ## Set a custom prefetch count for the receiver(s)
#   # prefetch_count = 1000
#
#   ## Add an epoch to the receiver(s)
#   # epoch = 0
#
#   ## Change to set a custom user agent, "telegraf" is used by default
#   # user_agent = "telegraf"
#
#   ## To consume from a specific partition, set the partition_ids option.
#   ## An empty array will result in receiving from all partitions.
#   # partition_ids = ["0","1"]
#
#   ## Max undelivered messages
#   # max_undelivered_messages = 1000
#
#   ## Set either option below to true to use a system property as timestamp.
#   ## You have the choice between EnqueuedTime and IoTHubEnqueuedTime.
#   ## It is recommended to use this setting when the data itself has no timestamp.
#   # enqueued_time_as_ts = true
#   # iot_hub_enqueued_time_as_ts = true
#
#   ## Tags or fields to create from keys present in the application property bag.
#   ## These could for example be set by message enrichments in Azure IoT Hub.
#   # application_property_tags = []
#   # application_property_fields = []
#
#   ## Tag or field name to use for metadata
#   ## By default all metadata is disabled
#   # sequence_number_field = "SequenceNumber"
#   # enqueued_time_field = "EnqueuedTime"
#   # offset_field = "Offset"
#   # partition_id_tag = "PartitionID"
#   # partition_key_tag = "PartitionKey"
#   # iot_hub_device_connection_id_tag = "IoTHubDeviceConnectionID"
#   # iot_hub_auth_generation_id_tag = "IoTHubAuthGenerationID"
#   # iot_hub_connection_auth_method_tag = "IoTHubConnectionAuthMethod"
#   # iot_hub_connection_module_id_tag = "IoTHubConnectionModuleID"
#   # iot_hub_enqueued_time_field = "IoTHubEnqueuedTime"
#
#   ## Data format to consume.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   data_format = "influx"


# # Run executable as long-running input plugin
# [[inputs.execd]]
#   ## Program to run as daemon
#   command = ["telegraf-smartctl", "-d", "/dev/sda"]
#
#   ## Define how the process is signaled on each collection interval.
#   ## Valid values are:
#   ##   "none"   : Do not signal anything.
#   ##              The process must output metrics by itself.
#   ##   "STDIN"   : Send a newline on STDIN.
#   ##   "SIGHUP"  : Send a HUP signal. Not available on Windows.
#   ##   "SIGUSR1" : Send a USR1 signal. Not available on Windows.
#   ##   "SIGUSR2" : Send a USR2 signal. Not available on Windows.
#   signal = "none"
#
#   ## Delay before the process is restarted after an unexpected termination
#   restart_delay = "10s"
#
#   ## Data format to consume.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   data_format = "influx"


# # gNMI telemetry input plugin
# [[inputs.gnmi]]
#  ## Address and port of the gNMI GRPC server
#  addresses = ["10.49.234.114:57777"]
#
#  ## define credentials
#  username = "cisco"
#  password = "cisco"
#
#  ## gNMI encoding requested (one of: "proto", "json", "json_ietf", "bytes")
#  # encoding = "proto"
#
#  ## redial in case of failures after
#  redial = "10s"
#
#  ## enable client-side TLS and define CA to authenticate the device
#  # enable_tls = true
#  # tls_ca = "/etc/telegraf/ca.pem"
#  # insecure_skip_verify = true
#
#  ## define client-side TLS certificate & key to authenticate to the device
#  # tls_cert = "/etc/telegraf/cert.pem"
#  # tls_key = "/etc/telegraf/key.pem"
#
#  ## gNMI subscription prefix (optional, can usually be left empty)
#  ## See: https://github.com/openconfig/reference/blob/master/rpc/gnmi/gnmi-specification.md#222-paths
#  # origin = ""
#  # prefix = ""
#  # target = ""
#
#  ## Define additional aliases to map telemetry encoding paths to simple measurement names
#  #[inputs.gnmi.aliases]
#  #  ifcounters = "openconfig:/interfaces/interface/state/counters"
#
#  [[inputs.gnmi.subscription]]
#   ## Name of the measurement that will be emitted
#   name = "ifcounters"
#
#   ## Origin and path of the subscription
#   ## See: https://github.com/openconfig/reference/blob/master/rpc/gnmi/gnmi-specification.md#222-paths
#   ##
#   ## origin usually refers to a (YANG) data model implemented by the device
#   ## and path to a specific substructure inside it that should be subscribed to (similar to an XPath)
#   ## YANG models can be found e.g. here: https://github.com/YangModels/yang/tree/master/vendor/cisco/xr
#   origin = "openconfig-interfaces"
#   path = "/interfaces/interface/state/counters"
#
#   # Subscription mode (one of: "target_defined", "sample", "on_change") and interval
#   subscription_mode = "sample"
#   sample_interval = "10s"
#
#   ## Suppress redundant transmissions when measured values are unchanged
#   # suppress_redundant = false
#
#   ## If suppression is enabled, send updates at least every X seconds anyway
#   # heartbeat_interval = "60s"
#
#   #[[inputs.gnmi.subscription]]
#     # name = "descr"
#     # origin = "openconfig-interfaces"
#     # path = "/interfaces/interface/state/description"
#     # subscription_mode = "on_change"
#
#     ## If tag_only is set, the subscription in question will be utilized to maintain a map of
#     ## tags to apply to other measurements emitted by the plugin, by matching path keys
#     ## All fields from the tag-only subscription will be applied as tags to other readings,
#     ## in the format <name>_<fieldBase>.
#     # tag_only = true


# # Accept metrics over InfluxDB 1.x HTTP API
# [[inputs.http_listener]]
#   ## DEPRECATED: The 'http_listener' plugin is deprecated in version 1.9.0, has been renamed to 'influxdb_listener', use 'inputs.influxdb_listener' or 'inputs.http_listener_v2' instead.
#   ## Address and port to host InfluxDB listener on
#   service_address = ":8186"
#
#   ## maximum duration before timing out read of the request
#   read_timeout = "10s"
#   ## maximum duration before timing out write of the response
#   write_timeout = "10s"
#
#   ## Maximum allowed HTTP request body size in bytes.
#   ## 0 means to use the default of 32MiB.
#   max_body_size = "32MiB"
#
#   ## Optional tag name used to store the database.
#   ## If the write has a database in the query string then it will be kept in this tag name.
#   ## This tag can be used in downstream outputs.
#   ## The default value of nothing means it will be off and the database will not be recorded.
#   # database_tag = ""
#
#   ## If set the retention policy specified in the write query will be added as
#   ## the value of this tag name.
#   # retention_policy_tag = ""
#
#   ## Set one or more allowed client CA certificate file names to
#   ## enable mutually authenticated TLS connections
#   tls_allowed_cacerts = ["/etc/telegraf/clientca.pem"]
#
#   ## Add service certificate and key
#   tls_cert = "/etc/telegraf/cert.pem"
#   tls_key = "/etc/telegraf/key.pem"
#
#   ## Optional username and password to accept for HTTP basic authentication.
#   ## You probably want to make sure you have TLS configured above for this.
#   # basic_username = "foobar"
#   # basic_password = "barfoo"
#
#   ## Influx line protocol parser
#   ## 'internal' is the default. 'upstream' is a newer parser that is faster
#   ## and more memory efficient.
#   # parser_type = "internal"


# # Generic HTTP write listener
# [[inputs.http_listener_v2]]
#   ## Address and port to host HTTP listener on
#   service_address = ":8080"
#
#   ## Paths to listen to.
#   # paths = ["/telegraf"]
#
#   ## Save path as http_listener_v2_path tag if set to true
#   # path_tag = false
#
#   ## HTTP methods to accept.
#   # methods = ["POST", "PUT"]
#
#   ## maximum duration before timing out read of the request
#   # read_timeout = "10s"
#   ## maximum duration before timing out write of the response
#   # write_timeout = "10s"
#
#   ## Maximum allowed http request body size in bytes.
#   ## 0 means to use the default of 524,288,000 bytes (500 mebibytes)
#   # max_body_size = "500MB"
#
#   ## Part of the request to consume.  Available options are "body" and
#   ## "query".
#   # data_source = "body"
#
#   ## Set one or more allowed client CA certificate file names to
#   ## enable mutually authenticated TLS connections
#   # tls_allowed_cacerts = ["/etc/telegraf/clientca.pem"]
#
#   ## Add service certificate and key
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#
#   ## Optional username and password to accept for HTTP basic authentication.
#   ## You probably want to make sure you have TLS configured above for this.
#   # basic_username = "foobar"
#   # basic_password = "barfoo"
#
#   ## Optional setting to map http headers into tags
#   ## If the http header is not present on the request, no corresponding tag will be added
#   ## If multiple instances of the http header are present, only the first value will be used
#   # http_header_tags = {"HTTP_HEADER" = "TAG_NAME"}
#
#   ## Data format to consume.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   data_format = "influx"


# # Accept metrics over InfluxDB 1.x HTTP API
# [[inputs.influxdb_listener]]
#   ## Address and port to host InfluxDB listener on
#   service_address = ":8186"
#
#   ## maximum duration before timing out read of the request
#   read_timeout = "10s"
#   ## maximum duration before timing out write of the response
#   write_timeout = "10s"
#
#   ## Maximum allowed HTTP request body size in bytes.
#   ## 0 means to use the default of 32MiB.
#   max_body_size = "32MiB"
#
#   ## Optional tag name used to store the database.
#   ## If the write has a database in the query string then it will be kept in this tag name.
#   ## This tag can be used in downstream outputs.
#   ## The default value of nothing means it will be off and the database will not be recorded.
#   # database_tag = ""
#
#   ## If set the retention policy specified in the write query will be added as
#   ## the value of this tag name.
#   # retention_policy_tag = ""
#
#   ## Set one or more allowed client CA certificate file names to
#   ## enable mutually authenticated TLS connections
#   tls_allowed_cacerts = ["/etc/telegraf/clientca.pem"]
#
#   ## Add service certificate and key
#   tls_cert = "/etc/telegraf/cert.pem"
#   tls_key = "/etc/telegraf/key.pem"
#
#   ## Optional username and password to accept for HTTP basic authentication.
#   ## You probably want to make sure you have TLS configured above for this.
#   # basic_username = "foobar"
#   # basic_password = "barfoo"
#
#   ## Influx line protocol parser
#   ## 'internal' is the default. 'upstream' is a newer parser that is faster
#   ## and more memory efficient.
#   # parser_type = "internal"


# # Accept metrics over InfluxDB 2.x HTTP API
# [[inputs.influxdb_v2_listener]]
#   ## Address and port to host InfluxDB listener on
#   ## (Double check the port. Could be 9999 if using OSS Beta)
#   service_address = ":8086"
#
#   ## Maximum allowed HTTP request body size in bytes.
#   ## 0 means to use the default of 32MiB.
#   # max_body_size = "32MiB"
#
#   ## Optional tag to determine the bucket.
#   ## If the write has a bucket in the query string then it will be kept in this tag name.
#   ## This tag can be used in downstream outputs.
#   ## The default value of nothing means it will be off and the database will not be recorded.
#   # bucket_tag = ""
#
#   ## Set one or more allowed client CA certificate file names to
#   ## enable mutually authenticated TLS connections
#   # tls_allowed_cacerts = ["/etc/telegraf/clientca.pem"]
#
#   ## Add service certificate and key
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#
#   ## Optional token to accept for HTTP authentication.
#   ## You probably want to make sure you have TLS configured above for this.
#   # token = "some-long-shared-secret-token"
#
#   ## Influx line protocol parser
#   ## 'internal' is the default. 'upstream' is a newer parser that is faster
#   ## and more memory efficient.
#   # parser_type = "internal"


# # Intel Performance Monitoring Unit plugin exposes Intel PMU metrics available through Linux Perf subsystem
# [[inputs.intel_pmu]]
#   ## List of filesystem locations of JSON files that contain PMU event definitions.
#   event_definitions = ["/var/cache/pmu/GenuineIntel-6-55-4-core.json", "/var/cache/pmu/GenuineIntel-6-55-4-uncore.json"]
#
#   ## List of core events measurement entities. There can be more than one core_events sections.
#   [[inputs.intel_pmu.core_events]]
#     ## List of events to be counted. Event names shall match names from event_definitions files.
#     ## Single entry can contain name of the event (case insensitive) augmented with config options and perf modifiers.
#     ## If absent, all core events from provided event_definitions are counted skipping unresolvable ones.
#     events = ["INST_RETIRED.ANY", "CPU_CLK_UNHALTED.THREAD_ANY:config1=0x4043200000000k"]
#
#     ## Limits the counting of events to core numbers specified.
#     ## If absent, events are counted on all cores.
#     ## Single "0", multiple "0,1,2" and range "0-2" notation is supported for each array element.
#     ##   example: cores = ["0,2", "4", "12-16"]
#     cores = ["0"]
#
#     ## Indicator that plugin shall attempt to run core_events.events as a single perf group.
#     ## If absent or set to false, each event is counted individually. Defaults to false.
#     ## This limits the number of events that can be measured to a maximum of available hardware counters per core.
#     ## Could vary depending on type of event, use of fixed counters.
#     # perf_group = false
#
#     ## Optionally set a custom tag value that will be added to every measurement within this events group.
#     ## Can be applied to any group of events, unrelated to perf_group setting.
#     # events_tag = ""
#
#   ## List of uncore event measurement entities. There can be more than one uncore_events sections.
#   [[inputs.intel_pmu.uncore_events]]
#     ## List of events to be counted. Event names shall match names from event_definitions files.
#     ## Single entry can contain name of the event (case insensitive) augmented with config options and perf modifiers.
#     ## If absent, all uncore events from provided event_definitions are counted skipping unresolvable ones.
#     events = ["UNC_CHA_CLOCKTICKS", "UNC_CHA_TOR_OCCUPANCY.IA_MISS"]
#
#     ## Limits the counting of events to specified sockets.
#     ## If absent, events are counted on all sockets.
#     ## Single "0", multiple "0,1" and range "0-1" notation is supported for each array element.
#     ##   example: sockets = ["0-2"]
#     sockets = ["0"]
#
#     ## Indicator that plugin shall provide an aggregated value for multiple units of same type distributed in an uncore.
#     ## If absent or set to false, events for each unit are exposed as separate metric. Defaults to false.
#     # aggregate_uncore_units = false
#
#     ## Optionally set a custom tag value that will be added to every measurement within this events group.
#     # events_tag = ""


# # Intel Resource Director Technology plugin
# [[inputs.intel_rdt]]
# 	## Optionally set sampling interval to Nx100ms.
# 	## This value is propagated to pqos tool. Interval format is defined by pqos itself.
# 	## If not provided or provided 0, will be set to 10 = 10x100ms = 1s.
# 	# sampling_interval = "10"
# 	
# 	## Optionally specify the path to pqos executable.
# 	## If not provided, auto discovery will be performed.
# 	# pqos_path = "/usr/local/bin/pqos"
#
# 	## Optionally specify if IPC and LLC_Misses metrics shouldn't be propagated.
# 	## If not provided, default value is false.
# 	# shortened_metrics = false
# 	
# 	## Specify the list of groups of CPU core(s) to be provided as pqos input.
# 	## Mandatory if processes aren't set and forbidden if processes are specified.
# 	## e.g. ["0-3", "4,5,6"] or ["1-3,4"]
# 	# cores = ["0-3"]
# 	
# 	## Specify the list of processes for which Metrics will be collected.
# 	## Mandatory if cores aren't set and forbidden if cores are specified.
# 	## e.g. ["qemu", "pmd"]
# 	# processes = ["process"]
#
# 	## Specify if the pqos process should be called with sudo.
# 	## Mandatory if the telegraf process does not run as root.
# 	# use_sudo = false


# # Read JTI OpenConfig Telemetry from listed sensors
# [[inputs.jti_openconfig_telemetry]]
#   ## List of device addresses to collect telemetry from
#   servers = ["localhost:1883"]
#
#   ## Authentication details. Username and password are must if device expects
#   ## authentication. Client ID must be unique when connecting from multiple instances
#   ## of telegraf to the same device
#   username = "user"
#   password = "pass"
#   client_id = "telegraf"
#
#   ## Frequency to get data
#   sample_frequency = "1000ms"
#
#   ## Sensors to subscribe for
#   ## A identifier for each sensor can be provided in path by separating with space
#   ## Else sensor path will be used as identifier
#   ## When identifier is used, we can provide a list of space separated sensors.
#   ## A single subscription will be created with all these sensors and data will
#   ## be saved to measurement with this identifier name
#   sensors = [
#    "/interfaces/",
#    "collection /components/ /lldp",
#   ]
#
#   ## We allow specifying sensor group level reporting rate. To do this, specify the
#   ## reporting rate in Duration at the beginning of sensor paths / collection
#   ## name. For entries without reporting rate, we use configured sample frequency
#   sensors = [
#    "1000ms customReporting /interfaces /lldp",
#    "2000ms collection /components",
#    "/interfaces",
#   ]
#
#   ## Optional TLS Config
#   # enable_tls = true
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## Delay between retry attempts of failed RPC calls or streams. Defaults to 1000ms.
#   ## Failed streams/calls will not be retried if 0 is provided
#   retry_delay = "1000ms"
#
#   ## To treat all string values as tags, set this to true
#   str_as_tags = false


# # Read metrics from Kafka topics
# [[inputs.kafka_consumer]]
#   ## Kafka brokers.
#   brokers = ["localhost:9092"]
#
#   ## Topics to consume.
#   topics = ["telegraf"]
#
#   ## When set this tag will be added to all metrics with the topic as the value.
#   # topic_tag = ""
#
#   ## Optional Client id
#   # client_id = "Telegraf"
#
#   ## Set the minimal supported Kafka version.  Setting this enables the use of new
#   ## Kafka features and APIs.  Must be 0.10.2.0 or greater.
#   ##   ex: version = "1.1.0"
#   # version = ""
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## SASL authentication credentials.  These settings should typically be used
#   ## with TLS encryption enabled
#   # sasl_username = "kafka"
#   # sasl_password = "secret"
#
#   ## Optional SASL:
#   ## one of: OAUTHBEARER, PLAIN, SCRAM-SHA-256, SCRAM-SHA-512, GSSAPI
#   ## (defaults to PLAIN)
#   # sasl_mechanism = ""
#
#   ## used if sasl_mechanism is GSSAPI (experimental)
#   # sasl_gssapi_service_name = ""
#   # ## One of: KRB5_USER_AUTH and KRB5_KEYTAB_AUTH
#   # sasl_gssapi_auth_type = "KRB5_USER_AUTH"
#   # sasl_gssapi_kerberos_config_path = "/"
#   # sasl_gssapi_realm = "realm"
#   # sasl_gssapi_key_tab_path = ""
#   # sasl_gssapi_disable_pafxfast = false
#
#   ## used if sasl_mechanism is OAUTHBEARER (experimental)
#   # sasl_access_token = ""
#
#   ## SASL protocol version.  When connecting to Azure EventHub set to 0.
#   # sasl_version = 1
#
#   # Disable Kafka metadata full fetch
#   # metadata_full = false
#
#   ## Name of the consumer group.
#   # consumer_group = "telegraf_metrics_consumers"
#
#   ## Compression codec represents the various compression codecs recognized by
#   ## Kafka in messages.
#   ##  0 : None
#   ##  1 : Gzip
#   ##  2 : Snappy
#   ##  3 : LZ4
#   ##  4 : ZSTD
#    # compression_codec = 0
#
#   ## Initial offset position; one of "oldest" or "newest".
#   # offset = "oldest"
#
#   ## Consumer group partition assignment strategy; one of "range", "roundrobin" or "sticky".
#   # balance_strategy = "range"
#
#   ## Maximum length of a message to consume, in bytes (default 0/unlimited);
#   ## larger messages are dropped
#   max_message_len = 1000000
#
#   ## Maximum messages to read from the broker that have not been written by an
#   ## output.  For best throughput set based on the number of metrics within
#   ## each message and the size of the output's metric_batch_size.
#   ##
#   ## For example, if each message from the queue contains 10 metrics and the
#   ## output metric_batch_size is 1000, setting this to 100 will ensure that a
#   ## full batch is collected and the write is triggered immediately without
#   ## waiting until the next flush_interval.
#   # max_undelivered_messages = 1000
#
#   ## Maximum amount of time the consumer should take to process messages. If
#   ## the debug log prints messages from sarama about 'abandoning subscription
#   ## to [topic] because consuming was taking too long', increase this value to
#   ## longer than the time taken by the output plugin(s).
#   ##
#   ## Note that the effective timeout could be between 'max_processing_time' and
#   ## '2 * max_processing_time'.
#   # max_processing_time = "100ms"
#
#   ## Data format to consume.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   data_format = "influx"


# # Read metrics from Kafka topic(s)
# [[inputs.kafka_consumer_legacy]]
#   ## DEPRECATED: The 'kafka_consumer_legacy' plugin is deprecated in version 1.4.0, use 'inputs.kafka_consumer' instead, NOTE: 'kafka_consumer' only supports Kafka v0.8+.
#   ## topic(s) to consume
#   topics = ["telegraf"]
#
#   ## an array of Zookeeper connection strings
#   zookeeper_peers = ["localhost:2181"]
#
#   ## Zookeeper Chroot
#   zookeeper_chroot = ""
#
#   ## the name of the consumer group
#   consumer_group = "telegraf_metrics_consumers"
#
#   ## Offset (must be either "oldest" or "newest")
#   offset = "oldest"
#
#   ## Data format to consume.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   data_format = "influx"
#
#   ## Maximum length of a message to consume, in bytes (default 0/unlimited);
#   ## larger messages are dropped
#   max_message_len = 65536


# # Configuration for the AWS Kinesis input.
# [[inputs.kinesis_consumer]]
#   ## Amazon REGION of kinesis endpoint.
#   region = "ap-southeast-2"
#
#   ## Amazon Credentials
#   ## Credentials are loaded in the following order
#   ## 1) Web identity provider credentials via STS if role_arn and web_identity_token_file are specified
#   ## 2) Assumed credentials via STS if role_arn is specified
#   ## 3) explicit credentials from 'access_key' and 'secret_key'
#   ## 4) shared profile from 'profile'
#   ## 5) environment variables
#   ## 6) shared credentials file
#   ## 7) EC2 Instance Profile
#   # access_key = ""
#   # secret_key = ""
#   # token = ""
#   # role_arn = ""
#   # web_identity_token_file = ""
#   # role_session_name = ""
#   # profile = ""
#   # shared_credential_file = ""
#
#   ## Endpoint to make request against, the correct endpoint is automatically
#   ## determined and this option should only be set if you wish to override the
#   ## default.
#   ##   ex: endpoint_url = "http://localhost:8000"
#   # endpoint_url = ""
#
#   ## Kinesis StreamName must exist prior to starting telegraf.
#   streamname = "StreamName"
#
#   ## Shard iterator type (only 'TRIM_HORIZON' and 'LATEST' currently supported)
#   # shard_iterator_type = "TRIM_HORIZON"
#
#   ## Maximum messages to read from the broker that have not been written by an
#   ## output.  For best throughput set based on the number of metrics within
#   ## each message and the size of the output's metric_batch_size.
#   ##
#   ## For example, if each message from the queue contains 10 metrics and the
#   ## output metric_batch_size is 1000, setting this to 100 will ensure that a
#   ## full batch is collected and the write is triggered immediately without
#   ## waiting until the next flush_interval.
#   # max_undelivered_messages = 1000
#
#   ## Data format to consume.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   data_format = "influx"
#
#   ##
#   ## The content encoding of the data from kinesis
#   ## If you are processing a cloudwatch logs kinesis stream then set this to "gzip"
#   ## as AWS compresses cloudwatch log data before it is sent to kinesis (aws
#   ## also base64 encodes the zip byte data before pushing to the stream.  The base64 decoding
#   ## is done automatically by the golang sdk, as data is read from kinesis)
#   ##
#   # content_encoding = "identity"
#
#   ## Optional
#   ## Configuration for a dynamodb checkpoint
#   [inputs.kinesis_consumer.checkpoint_dynamodb]
# 	## unique name for this consumer
# 	app_name = "default"
# 	table_name = "default"


# # Listener capable of handling KNX bus messages provided through a KNX-IP Interface.
# [[inputs.knx_listener]]
#   ## Type of KNX-IP interface.
#   ## Can be either "tunnel" or "router".
#   # service_type = "tunnel"
#
#   ## Address of the KNX-IP interface.
#   service_address = "localhost:3671"
#
#   ## Measurement definition(s)
#   # [[inputs.knx_listener.measurement]]
#   #   ## Name of the measurement
#   #   name = "temperature"
#   #   ## Datapoint-Type (DPT) of the KNX messages
#   #   dpt = "9.001"
#   #   ## List of Group-Addresses (GAs) assigned to the measurement
#   #   addresses = ["5/5/1"]
#
#   # [[inputs.knx_listener.measurement]]
#   #   name = "illumination"
#   #   dpt = "9.004"
#   #   addresses = ["5/5/3"]


# # Read metrics off Arista LANZ, via socket
# [[inputs.lanz]]
#   ## URL to Arista LANZ endpoint
#   servers = [
#     "tcp://127.0.0.1:50001"
#   ]


# # Stream and parse log file(s).
# [[inputs.logparser]]
#   ## DEPRECATED: The 'logparser' plugin is deprecated in version 1.15.0, use 'inputs.tail' with 'grok' data format instead.
#   ## Log files to parse.
#   ## These accept standard unix glob matching rules, but with the addition of
#   ## ** as a "super asterisk". ie:
#   ##   /var/log/**.log     -> recursively find all .log files in /var/log
#   ##   /var/log/*/*.log    -> find all .log files with a parent dir in /var/log
#   ##   /var/log/apache.log -> only tail the apache log file
#   files = ["/var/log/apache/access.log"]
#
#   ## Read files that currently exist from the beginning. Files that are created
#   ## while telegraf is running (and that match the "files" globs) will always
#   ## be read from the beginning.
#   from_beginning = false
#
#   ## Method used to watch for file updates.  Can be either "inotify" or "poll".
#   # watch_method = "inotify"
#
#   ## Parse logstash-style "grok" patterns:
#   [inputs.logparser.grok]
#     ## This is a list of patterns to check the given log file(s) for.
#     ## Note that adding patterns here increases processing time. The most
#     ## efficient configuration is to have one pattern per logparser.
#     ## Other common built-in patterns are:
#     ##   %{COMMON_LOG_FORMAT}   (plain apache & nginx access logs)
#     ##   %{COMBINED_LOG_FORMAT} (access logs + referrer & agent)
#     patterns = ["%{COMBINED_LOG_FORMAT}"]
#
#     ## Name of the outputted measurement name.
#     measurement = "apache_access_log"
#
#     ## Full path(s) to custom pattern files.
#     custom_pattern_files = []
#
#     ## Custom patterns can also be defined here. Put one pattern per line.
#     custom_patterns = '''
#     '''
#
#     ## Timezone allows you to provide an override for timestamps that
#     ## don't already include an offset
#     ## e.g. 04/06/2016 12:41:45 data one two 5.43µs
#     ##
#     ## Default: "" which renders UTC
#     ## Options are as follows:
#     ##   1. Local             -- interpret based on machine localtime
#     ##   2. "Canada/Eastern"  -- Unix TZ values like those found in https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
#     ##   3. UTC               -- or blank/unspecified, will return timestamp in UTC
#     # timezone = "Canada/Eastern"
#
# 	## When set to "disable", timestamp will not incremented if there is a
# 	## duplicate.
#     # unique_timestamp = "auto"


# # Read metrics from MQTT topic(s)
# [[inputs.mqtt_consumer]]
#   ## Broker URLs for the MQTT server or cluster.  To connect to multiple
#   ## clusters or standalone servers, use a separate plugin instance.
#   ##   example: servers = ["tcp://localhost:1883"]
#   ##            servers = ["ssl://localhost:1883"]
#   ##            servers = ["ws://localhost:1883"]
#   servers = ["tcp://127.0.0.1:1883"]
#   ## Topics that will be subscribed to.
#   topics = [
#     "telegraf/host01/cpu",
#     "telegraf/+/mem",
#     "sensors/#",
#   ]
#   # topic_fields = "_/_/_/temperature"
#   ## The message topic will be stored in a tag specified by this value.  If set
#   ## to the empty string no topic tag will be created.
#   # topic_tag = "topic"
#   ## QoS policy for messages
#   ##   0 = at most once
#   ##   1 = at least once
#   ##   2 = exactly once
#   ##
#   ## When using a QoS of 1 or 2, you should enable persistent_session to allow
#   ## resuming unacknowledged messages.
#   # qos = 0
#   ## Connection timeout for initial connection in seconds
#   # connection_timeout = "30s"
#   ## Maximum messages to read from the broker that have not been written by an
#   ## output.  For best throughput set based on the number of metrics within
#   ## each message and the size of the output's metric_batch_size.
#   ##
#   ## For example, if each message from the queue contains 10 metrics and the
#   ## output metric_batch_size is 1000, setting this to 100 will ensure that a
#   ## full batch is collected and the write is triggered immediately without
#   ## waiting until the next flush_interval.
#   # max_undelivered_messages = 1000
#   ## Persistent session disables clearing of the client session on connection.
#   ## In order for this option to work you must also set client_id to identify
#   ## the client.  To receive messages that arrived while the client is offline,
#   ## also set the qos option to 1 or 2 and don't forget to also set the QoS when
#   ## publishing.
#   # persistent_session = false
#   ## If unset, a random client ID will be generated.
#   # client_id = ""
#   ## Username and password to connect MQTT server.
#   # username = "telegraf"
#   # password = "metricsmetricsmetricsmetrics"
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#   ## Data format to consume.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   data_format = "influx"
#   ## Enable extracting tag values from MQTT topics
#   ## _ denotes an ignored entry in the topic path
#   ## [[inputs.mqtt_consumer.topic_parsing]]
#   ##  topic = ""
#   ##  measurement = ""
#   ##  tags = ""
#   ##  fields = ""
#   ## [inputs.mqtt_consumer.topic_parsing.types]
#   ##


# # Read metrics from NATS subject(s)
# [[inputs.nats_consumer]]
#   ## urls of NATS servers
#   servers = ["nats://localhost:4222"]
#
#   ## subject(s) to consume
#   subjects = ["telegraf"]
#
#   ## name a queue group
#   queue_group = "telegraf_consumers"
#
#   ## Optional credentials
#   # username = ""
#   # password = ""
#
#   ## Optional NATS 2.0 and NATS NGS compatible user credentials
#   # credentials = "/etc/telegraf/nats.creds"
#
#   ## Use Transport Layer Security
#   # secure = false
#
#   ## Optional TLS Config
#   # tls_ca = "/etc/telegraf/ca.pem"
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## Sets the limits for pending msgs and bytes for each subscription
#   ## These shouldn't need to be adjusted except in very high throughput scenarios
#   # pending_message_limit = 65536
#   # pending_bytes_limit = 67108864
#
#   ## Maximum messages to read from the broker that have not been written by an
#   ## output.  For best throughput set based on the number of metrics within
#   ## each message and the size of the output's metric_batch_size.
#   ##
#   ## For example, if each message from the queue contains 10 metrics and the
#   ## output metric_batch_size is 1000, setting this to 100 will ensure that a
#   ## full batch is collected and the write is triggered immediately without
#   ## waiting until the next flush_interval.
#   # max_undelivered_messages = 1000
#
#   ## Data format to consume.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   data_format = "influx"


# # Read NSQ topic for metrics.
# [[inputs.nsq_consumer]]
#   ## An array representing the NSQD TCP HTTP Endpoints
#   nsqd = ["localhost:4150"]
#
#   ## An array representing the NSQLookupd HTTP Endpoints
#   nsqlookupd = ["localhost:4161"]
#   topic = "telegraf"
#   channel = "consumer"
#   max_in_flight = 100
#
#   ## Maximum messages to read from the broker that have not been written by an
#   ## output.  For best throughput set based on the number of metrics within
#   ## each message and the size of the output's metric_batch_size.
#   ##
#   ## For example, if each message from the queue contains 10 metrics and the
#   ## output metric_batch_size is 1000, setting this to 100 will ensure that a
#   ## full batch is collected and the write is triggered immediately without
#   ## waiting until the next flush_interval.
#   # max_undelivered_messages = 1000
#
#   ## Data format to consume.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   data_format = "influx"


# # Receive OpenTelemetry traces, metrics, and logs over gRPC
# [[inputs.opentelemetry]]
#   ## Override the default (0.0.0.0:4317) destination OpenTelemetry gRPC service
#   ## address:port
#   # service_address = "0.0.0.0:4317"
#
#   ## Override the default (5s) new connection timeout
#   # timeout = "5s"
#
#   ## Override the default (prometheus-v1) metrics schema.
#   ## Supports: "prometheus-v1", "prometheus-v2"
#   ## For more information about the alternatives, read the Prometheus input
#   ## plugin notes.
#   # metrics_schema = "prometheus-v1"
#
#   ## Optional TLS Config.
#   ## For advanced options: https://github.com/influxdata/telegraf/blob/v1.18.3/docs/TLS.md
#   ##
#   ## Set one or more allowed client CA certificate file names to
#   ## enable mutually authenticated TLS connections.
#   # tls_allowed_cacerts = ["/etc/telegraf/clientca.pem"]
#   ## Add service certificate and key.
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"


# # Read metrics from one or many pgbouncer servers
# [[inputs.pgbouncer]]
#   ## specify address via a url matching:
#   ##   postgres://[pqgotest[:password]]@localhost[/dbname]\
#   ##       ?sslmode=[disable|verify-ca|verify-full]
#   ## or a simple string:
#   ##   host=localhost user=pqgotest password=... sslmode=... dbname=app_production
#   ##
#   ## All connection parameters are optional.
#   ##
#   address = "host=localhost user=pgbouncer sslmode=disable"


# # Read metrics from one or many postgresql servers
# [[inputs.postgresql]]
#   ## specify address via a url matching:
#   ##   postgres://[pqgotest[:password]]@localhost[/dbname]\
#   ##       ?sslmode=[disable|verify-ca|verify-full]
#   ## or a simple string:
#   ##   host=localhost user=pqgotest password=... sslmode=... dbname=app_production
#   ##
#   ## All connection parameters are optional.
#   ##
#   ## Without the dbname parameter, the driver will default to a database
#   ## with the same name as the user. This dbname is just for instantiating a
#   ## connection with the server and doesn't restrict the databases we are trying
#   ## to grab metrics for.
#   ##
#   address = "host=localhost user=postgres sslmode=disable"
#   ## A custom name for the database that will be used as the "server" tag in the
#   ## measurement output. If not specified, a default one generated from
#   ## the connection address is used.
#   # outputaddress = "db01"
#
#   ## connection configuration.
#   ## maxlifetime - specify the maximum lifetime of a connection.
#   ## default is forever (0s)
#   max_lifetime = "0s"
#
#   ## A  list of databases to explicitly ignore.  If not specified, metrics for all
#   ## databases are gathered.  Do NOT use with the 'databases' option.
#   # ignored_databases = ["postgres", "template0", "template1"]
#
#   ## A list of databases to pull metrics about. If not specified, metrics for all
#   ## databases are gathered.  Do NOT use with the 'ignored_databases' option.
#   # databases = ["app_production", "testing"]
#
#   ## Whether to use prepared statements when connecting to the database.
#   ## This should be set to false when connecting through a PgBouncer instance
#   ## with pool_mode set to transaction.
#   # prepared_statements = true


# # Read metrics from one or many postgresql servers
# [[inputs.postgresql_extensible]]
#   ## specify address via a url matching:
#   ##   postgres://[pqgotest[:password]]@localhost[/dbname]\
#   ##       ?sslmode=[disable|verify-ca|verify-full]
#   ## or a simple string:
#   ##   host=localhost user=pqgotest password=... sslmode=... dbname=app_production
#   #
#   ## All connection parameters are optional.  #
#   ## Without the dbname parameter, the driver will default to a database
#   ## with the same name as the user. This dbname is just for instantiating a
#   ## connection with the server and doesn't restrict the databases we are trying
#   ## to grab metrics for.
#   #
#   address = "host=localhost user=postgres sslmode=disable"
#
#   ## connection configuration.
#   ## maxlifetime - specify the maximum lifetime of a connection.
#   ## default is forever (0s)
#   max_lifetime = "0s"
#
#   ## Whether to use prepared statements when connecting to the database.
#   ## This should be set to false when connecting through a PgBouncer instance
#   ## with pool_mode set to transaction.
#   # prepared_statements = true
#
#   ## A list of databases to pull metrics about. If not specified, metrics for all
#   ## databases are gathered.
#   ## databases = ["app_production", "testing"]
#   #
#   ## A custom name for the database that will be used as the "server" tag in the
#   ## measurement output. If not specified, a default one generated from
#   ## the connection address is used.
#   # outputaddress = "db01"
#   #
#   ## Define the toml config where the sql queries are stored
#   ## New queries can be added, if the withdbname is set to true and there is no
#   ## databases defined in the 'databases field', the sql query is ended by a
#   ## 'is not null' in order to make the query succeed.
#   ## Example :
#   ## The sqlquery : "SELECT * FROM pg_stat_database where datname" become
#   ## "SELECT * FROM pg_stat_database where datname IN ('postgres', 'pgbench')"
#   ## because the databases variable was set to ['postgres', 'pgbench' ] and the
#   ## withdbname was true. Be careful that if the withdbname is set to false you
#   ## don't have to define the where clause (aka with the dbname) the tagvalue
#   ## field is used to define custom tags (separated by commas)
#   ## The optional "measurement" value can be used to override the default
#   ## output measurement name ("postgresql").
#   ##
#   ## The script option can be used to specify the .sql file path.
#   ## If script and sqlquery options specified at same time, sqlquery will be used
#   ##
#   ## the tagvalue field is used to define custom tags (separated by comas).
#   ## the query is expected to return columns which match the names of the
#   ## defined tags. The values in these columns must be of a string-type,
#   ## a number-type or a blob-type.
#   ##
#   ## The timestamp field is used to override the data points timestamp value. By
#   ## default, all rows inserted with current time. By setting a timestamp column,
#   ## the row will be inserted with that column's value.
#   ##
#   ## Structure :
#   ## [[inputs.postgresql_extensible.query]]
#   ##   sqlquery string
#   ##   version string
#   ##   withdbname boolean
#   ##   tagvalue string (comma separated)
#   ##   measurement string
#   ##   timestamp string
#   [[inputs.postgresql_extensible.query]]
#     sqlquery="SELECT * FROM pg_stat_database"
#     version=901
#     withdbname=false
#     tagvalue=""
#     measurement=""
#   [[inputs.postgresql_extensible.query]]
#     sqlquery="SELECT * FROM pg_stat_bgwriter"
#     version=901
#     withdbname=false
#     tagvalue="postgresql.stats"


# # Read metrics from one or many prometheus clients
# [[inputs.prometheus]]
#   ## An array of urls to scrape metrics from.
#   urls = ["http://localhost:9100/metrics"]
#
#   ## Metric version controls the mapping from Prometheus metrics into
#   ## Telegraf metrics.  When using the prometheus_client output, use the same
#   ## value in both plugins to ensure metrics are round-tripped without
#   ## modification.
#   ##
#   ##   example: metric_version = 1;
#   ##            metric_version = 2; recommended version
#   # metric_version = 1
#
#   ## Url tag name (tag containing scrapped url. optional, default is "url")
#   # url_tag = "url"
#
#   ## Whether the timestamp of the scraped metrics will be ignored.
#   ## If set to true, the gather time will be used.
#   # ignore_timestamp = false
#
#   ## An array of Kubernetes services to scrape metrics from.
#   # kubernetes_services = ["http://my-service-dns.my-namespace:9100/metrics"]
#
#   ## Kubernetes config file to create client from.
#   # kube_config = "/path/to/kubernetes.config"
#
#   ## Scrape Kubernetes pods for the following prometheus annotations:
#   ## - prometheus.io/scrape: Enable scraping for this pod
#   ## - prometheus.io/scheme: If the metrics endpoint is secured then you will need to
#   ##     set this to 'https' & most likely set the tls config.
#   ## - prometheus.io/path: If the metrics path is not /metrics, define it with this annotation.
#   ## - prometheus.io/port: If port is not 9102 use this annotation
#   # monitor_kubernetes_pods = true
#   ## Get the list of pods to scrape with either the scope of
#   ## - cluster: the kubernetes watch api (default, no need to specify)
#   ## - node: the local cadvisor api; for scalability. Note that the config node_ip or the environment variable NODE_IP must be set to the host IP.
#   # pod_scrape_scope = "cluster"
#   ## Only for node scrape scope: node IP of the node that telegraf is running on.
#   ## Either this config or the environment variable NODE_IP must be set.
#   # node_ip = "10.180.1.1"
# 	## Only for node scrape scope: interval in seconds for how often to get updated pod list for scraping.
# 	## Default is 60 seconds.
# 	# pod_scrape_interval = 60
#   ## Restricts Kubernetes monitoring to a single namespace
#   ##   ex: monitor_kubernetes_pods_namespace = "default"
#   # monitor_kubernetes_pods_namespace = ""
#   # label selector to target pods which have the label
#   # kubernetes_label_selector = "env=dev,app=nginx"
#   # field selector to target pods
#   # eg. To scrape pods on a specific node
#   # kubernetes_field_selector = "spec.nodeName=$HOSTNAME"
#
#   ## Scrape Services available in Consul Catalog
#   # [inputs.prometheus.consul]
#   #   enabled = true
#   #   agent = "http://localhost:8500"
#   #   query_interval = "5m"
#
#   #   [[inputs.prometheus.consul.query]]
#   #     name = "a service name"
#   #     tag = "a service tag"
#   #     url = 'http://{{if ne .ServiceAddress ""}}{{.ServiceAddress}}{{else}}{{.Address}}{{end}}:{{.ServicePort}}/{{with .ServiceMeta.metrics_path}}{{.}}{{else}}metrics{{end}}'
#   #     [inputs.prometheus.consul.query.tags]
#   #       host = "{{.Node}}"
#
#   ## Use bearer token for authorization. ('bearer_token' takes priority)
#   # bearer_token = "/path/to/bearer/token"
#   ## OR
#   # bearer_token_string = "abc_123"
#
#   ## HTTP Basic Authentication username and password. ('bearer_token' and
#   ## 'bearer_token_string' take priority)
#   # username = ""
#   # password = ""
#
#   ## Specify timeout duration for slower prometheus clients (default is 3s)
#   # response_timeout = "3s"
#
#   ## Optional TLS Config
#   # tls_ca = /path/to/cafile
#   # tls_cert = /path/to/certfile
#   # tls_key = /path/to/keyfile
#   ## Use TLS but skip chain & host verification
#   # insecure_skip_verify = false


# # RAS plugin exposes counter metrics for Machine Check Errors provided by RASDaemon (sqlite3 output is required).
# [[inputs.ras]]
#   ## Optional path to RASDaemon sqlite3 database.
#   ## Default: /var/lib/rasdaemon/ras-mc_event.db
#   # db_path = ""


# # Riemann protobuff listener.
# [[inputs.riemann_listener]]
#   ## URL to listen on.
#   ## Default is "tcp://:5555"
#   # service_address = "tcp://:8094"
#   # service_address = "tcp://127.0.0.1:http"
#   # service_address = "tcp4://:8094"
#   # service_address = "tcp6://:8094"
#   # service_address = "tcp6://[2001:db8::1]:8094"
#
#   ## Maximum number of concurrent connections.
#   ## 0 (default) is unlimited.
#   # max_connections = 1024
#   ## Read timeout.
#   ## 0 (default) is unlimited.
#   # read_timeout = "30s"
#   ## Optional TLS configuration.
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key  = "/etc/telegraf/key.pem"
#   ## Enables client authentication if set.
#   # tls_allowed_cacerts = ["/etc/telegraf/clientca.pem"]
#   ## Maximum socket buffer size (in bytes when no unit specified).
#   # read_buffer_size = "64KiB"
#   ## Period between keep alive probes.
#   ## 0 disables keep alive probes.
#   ## Defaults to the OS configuration.
#   # keep_alive_period = "5m"


# # SFlow V5 Protocol Listener
# [[inputs.sflow]]
#   ## Address to listen for sFlow packets.
#   ##   example: service_address = "udp://:6343"
#   ##            service_address = "udp4://:6343"
#   ##            service_address = "udp6://:6343"
#   service_address = "udp://:6343"
#
#   ## Set the size of the operating system's receive buffer.
#   ##   example: read_buffer_size = "64KiB"
#   # read_buffer_size = ""


# # Receive SNMP traps
# [[inputs.snmp_trap]]
#   ## Transport, local address, and port to listen on.  Transport must
#   ## be "udp://".  Omit local address to listen on all interfaces.
#   ##   example: "udp://127.0.0.1:1234"
#   ##
#   ## Special permissions may be required to listen on a port less than
#   ## 1024.  See README.md for details
#   ##
#   # service_address = "udp://:162"
#   ##
#   ## Path to mib files
#   # path = ["/usr/share/snmp/mibs"]
#   ##
#   ## Snmp version, defaults to 2c
#   # version = "2c"
#   ## SNMPv3 authentication and encryption options.
#   ##
#   ## Security Name.
#   # sec_name = "myuser"
#   ## Authentication protocol; one of "MD5", "SHA" or "".
#   # auth_protocol = "MD5"
#   ## Authentication password.
#   # auth_password = "pass"
#   ## Security Level; one of "noAuthNoPriv", "authNoPriv", or "authPriv".
#   # sec_level = "authNoPriv"
#   ## Privacy protocol used for encrypted messages; one of "DES", "AES", "AES192", "AES192C", "AES256", "AES256C" or "".
#   # priv_protocol = ""
#   ## Privacy password used for encrypted messages.
#   # priv_password = ""


# # Generic socket listener capable of handling multiple socket types.
# [[inputs.socket_listener]]
#   ## URL to listen on
#   # service_address = "tcp://:8094"
#   # service_address = "tcp://127.0.0.1:http"
#   # service_address = "tcp4://:8094"
#   # service_address = "tcp6://:8094"
#   # service_address = "tcp6://[2001:db8::1]:8094"
#   # service_address = "udp://:8094"
#   # service_address = "udp4://:8094"
#   # service_address = "udp6://:8094"
#   # service_address = "unix:///tmp/telegraf.sock"
#   # service_address = "unixgram:///tmp/telegraf.sock"
#
#   ## Change the file mode bits on unix sockets.  These permissions may not be
#   ## respected by some platforms, to safely restrict write permissions it is best
#   ## to place the socket into a directory that has previously been created
#   ## with the desired permissions.
#   ##   ex: socket_mode = "777"
#   # socket_mode = ""
#
#   ## Maximum number of concurrent connections.
#   ## Only applies to stream sockets (e.g. TCP).
#   ## 0 (default) is unlimited.
#   # max_connections = 1024
#
#   ## Read timeout.
#   ## Only applies to stream sockets (e.g. TCP).
#   ## 0 (default) is unlimited.
#   # read_timeout = "30s"
#
#   ## Optional TLS configuration.
#   ## Only applies to stream sockets (e.g. TCP).
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key  = "/etc/telegraf/key.pem"
#   ## Enables client authentication if set.
#   # tls_allowed_cacerts = ["/etc/telegraf/clientca.pem"]
#
#   ## Maximum socket buffer size (in bytes when no unit specified).
#   ## For stream sockets, once the buffer fills up, the sender will start backing up.
#   ## For datagram sockets, once the buffer fills up, metrics will start dropping.
#   ## Defaults to the OS default.
#   # read_buffer_size = "64KiB"
#
#   ## Period between keep alive probes.
#   ## Only applies to TCP sockets.
#   ## 0 disables keep alive probes.
#   ## Defaults to the OS configuration.
#   # keep_alive_period = "5m"
#
#   ## Data format to consume.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   # data_format = "influx"
#
#   ## Content encoding for message payloads, can be set to "gzip" to or
#   ## "identity" to apply no encoding.
#   # content_encoding = "identity"


# # Read metrics from SQL queries
# [[inputs.sql]]
#   ## Database Driver
#   ## See https://github.com/influxdata/telegraf/blob/master/docs/SQL_DRIVERS_INPUT.md for
#   ## a list of supported drivers.
#   driver = "mysql"
#
#   ## Data source name for connecting
#   ## The syntax and supported options depends on selected driver.
#   dsn = "username:password@mysqlserver:3307/dbname?param=value"
#
#   ## Timeout for any operation
#   ## Note that the timeout for queries is per query not per gather.
#   # timeout = "5s"
#
#   ## Connection time limits
#   ## By default the maximum idle time and maximum lifetime of a connection is unlimited, i.e. the connections
#   ## will not be closed automatically. If you specify a positive time, the connections will be closed after
#   ## idleing or existing for at least that amount of time, respectively.
#   # connection_max_idle_time = "0s"
#   # connection_max_life_time = "0s"
#
#   ## Connection count limits
#   ## By default the number of open connections is not limited and the number of maximum idle connections
#   ## will be inferred from the number of queries specified. If you specify a positive number for any of the
#   ## two options, connections will be closed when reaching the specified limit. The number of idle connections
#   ## will be clipped to the maximum number of connections limit if any.
#   # connection_max_open = 0
#   # connection_max_idle = auto
#
#   [[inputs.sql.query]]
#     ## Query to perform on the server
#     query="SELECT user,state,latency,score FROM Scoreboard WHERE application > 0"
#     ## Alternatively to specifying the query directly you can select a file here containing the SQL query.
#     ## Only one of 'query' and 'query_script' can be specified!
#     # query_script = "/path/to/sql/script.sql"
#
#     ## Name of the measurement
#     ## In case both measurement and 'measurement_col' are given, the latter takes precedence.
#     # measurement = "sql"
#
#     ## Column name containing the name of the measurement
#     ## If given, this will take precedence over the 'measurement' setting. In case a query result
#     ## does not contain the specified column, we fall-back to the 'measurement' setting.
#     # measurement_column = ""
#
#     ## Column name containing the time of the measurement
#     ## If ommited, the time of the query will be used.
#     # time_column = ""
#
#     ## Format of the time contained in 'time_col'
#     ## The time must be 'unix', 'unix_ms', 'unix_us', 'unix_ns', or a golang time format.
#     ## See https://golang.org/pkg/time/#Time.Format for details.
#     # time_format = "unix"
#
#     ## Column names containing tags
#     ## An empty include list will reject all columns and an empty exclude list will not exclude any column.
#     ## I.e. by default no columns will be returned as tag and the tags are empty.
#     # tag_columns_include = []
#     # tag_columns_exclude = []
#
# 		## Column names containing fields (explicit types)
#     ## Convert the given columns to the corresponding type. Explicit type conversions take precedence over
# 		## the automatic (driver-based) conversion below.
# 		## NOTE: Columns should not be specified for multiple types or the resulting type is undefined.
#     # field_columns_float = []
#     # field_columns_int = []
# 		# field_columns_uint = []
# 		# field_columns_bool = []
# 		# field_columns_string = []
#
#     ## Column names containing fields (automatic types)
#     ## An empty include list is equivalent to '[*]' and all returned columns will be accepted. An empty
#     ## exclude list will not exclude any column. I.e. by default all columns will be returned as fields.
#     ## NOTE: We rely on the database driver to perform automatic datatype conversion.
#     # field_columns_include = []
#     # field_columns_exclude = []


# # Read metrics from Microsoft SQL Server
# [[inputs.sqlserver]]
# ## Specify instances to monitor with a list of connection strings.
# ## All connection parameters are optional.
# ## By default, the host is localhost, listening on default port, TCP 1433.
# ##   for Windows, the user is the currently running AD user (SSO).
# ##   See https://github.com/denisenkom/go-mssqldb for detailed connection
# ##   parameters, in particular, tls connections can be created like so:
# ##   "encrypt=true;certificate=<cert>;hostNameInCertificate=<SqlServer host fqdn>"
# servers = [
#   "Server=192.168.1.10;Port=1433;User Id=<user>;Password=<pw>;app name=telegraf;log=1;",
# ]
#
# ## Authentication method
# ## valid methods: "connection_string", "AAD"
# # auth_method = "connection_string"
#
# ## "database_type" enables a specific set of queries depending on the database type.
# ## In the config file, the sql server plugin section should be repeated each with a set of servers for a specific database_type.
# ## Possible values for database_type are - "SQLServer" or "AzureSQLDB" or "AzureSQLManagedInstance" or "AzureSQLPool"
#
# database_type = "SQLServer"
#
# ## A list of queries to include. If not specified, all the below listed queries are used.
# include_query = []
#
# ## A list of queries to explicitly ignore.
# exclude_query = ["SQLServerAvailabilityReplicaStates", "SQLServerDatabaseReplicaStates"]
#
# ## Queries enabled by default for database_type = "SQLServer" are -
# ## SQLServerPerformanceCounters, SQLServerWaitStatsCategorized, SQLServerDatabaseIO, SQLServerProperties, SQLServerMemoryClerks,
# ## SQLServerSchedulers, SQLServerRequests, SQLServerVolumeSpace, SQLServerCpu, SQLServerAvailabilityReplicaStates, SQLServerDatabaseReplicaStates
#
# ## Queries enabled by default for database_type = "AzureSQLDB" are -
# ## AzureSQLDBResourceStats, AzureSQLDBResourceGovernance, AzureSQLDBWaitStats, AzureSQLDBDatabaseIO, AzureSQLDBServerProperties,
# ## AzureSQLDBOsWaitstats, AzureSQLDBMemoryClerks, AzureSQLDBPerformanceCounters, AzureSQLDBRequests, AzureSQLDBSchedulers
#
# ## Queries enabled by default for database_type = "AzureSQLManagedInstance" are -
# ## AzureSQLMIResourceStats, AzureSQLMIResourceGovernance, AzureSQLMIDatabaseIO, AzureSQLMIServerProperties, AzureSQLMIOsWaitstats,
# ## AzureSQLMIMemoryClerks, AzureSQLMIPerformanceCounters, AzureSQLMIRequests, AzureSQLMISchedulers
#
# ## Queries enabled by default for database_type = "AzureSQLPool" are -
# ## AzureSQLPoolResourceStats, AzureSQLPoolResourceGovernance, AzureSQLPoolDatabaseIO, AzureSQLPoolWaitStats,
# ## AzureSQLPoolMemoryClerks, AzureSQLPoolPerformanceCounters, AzureSQLPoolSchedulers


# # Statsd UDP/TCP Server
# [[inputs.statsd]]
#   ## Protocol, must be "tcp", "udp", "udp4" or "udp6" (default=udp)
#   protocol = "udp"
#
#   ## MaxTCPConnection - applicable when protocol is set to tcp (default=250)
#   max_tcp_connections = 250
#
#   ## Enable TCP keep alive probes (default=false)
#   tcp_keep_alive = false
#
#   ## Specifies the keep-alive period for an active network connection.
#   ## Only applies to TCP sockets and will be ignored if tcp_keep_alive is false.
#   ## Defaults to the OS configuration.
#   # tcp_keep_alive_period = "2h"
#
#   ## Address and port to host UDP listener on
#   service_address = ":8125"
#
#   ## The following configuration options control when telegraf clears it's cache
#   ## of previous values. If set to false, then telegraf will only clear it's
#   ## cache when the daemon is restarted.
#   ## Reset gauges every interval (default=true)
#   delete_gauges = true
#   ## Reset counters every interval (default=true)
#   delete_counters = true
#   ## Reset sets every interval (default=true)
#   delete_sets = true
#   ## Reset timings & histograms every interval (default=true)
#   delete_timings = true
#
#   ## Percentiles to calculate for timing & histogram stats
#   percentiles = [50.0, 90.0, 99.0, 99.9, 99.95, 100.0]
#
#   ## separator to use between elements of a statsd metric
#   metric_separator = "_"
#
#   ## Parses tags in the datadog statsd format
#   ## http://docs.datadoghq.com/guides/dogstatsd/
#   parse_data_dog_tags = false
#
#   ## Parses datadog extensions to the statsd format
#   datadog_extensions = false
#
#   ## Parses distributions metric as specified in the datadog statsd format
#   ## https://docs.datadoghq.com/developers/metrics/types/?tab=distribution#definition
#   datadog_distributions = false
#
#   ## Statsd data translation templates, more info can be read here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/TEMPLATE_PATTERN.md
#   # templates = [
#   #     "cpu.* measurement*"
#   # ]
#
#   ## Number of UDP messages allowed to queue up, once filled,
#   ## the statsd server will start dropping packets
#   allowed_pending_messages = 10000
#
#   ## Number of timing/histogram values to track per-measurement in the
#   ## calculation of percentiles. Raising this limit increases the accuracy
#   ## of percentiles but also increases the memory usage and cpu time.
#   percentile_limit = 1000
#
#   ## Max duration (TTL) for each metric to stay cached/reported without being updated.
#   #max_ttl = "1000h"
#
#   ## Sanitize name method
#   ## By default, telegraf will pass names directly as they are received.
#   ## However, upstream statsd now does sanitization of names which can be
#   ## enabled by using the "upstream" method option. This option will a) replace
#   ## white space with '_', replace '/' with '-', and remove charachters not
#   ## matching 'a-zA-Z_\-0-9\.;='.
#   #sanitize_name_method = ""


# # Suricata stats and alerts plugin
# [[inputs.suricata]]
#   ## Data sink for Suricata stats and alerts logs
#   # This is expected to be a filename of a
#   # unix socket to be created for listening.
#   source = "/var/run/suricata-stats.sock"
#
#   # Delimiter for flattening field keys, e.g. subitem "alert" of "detect"
#   # becomes "detect_alert" when delimiter is "_".
#   delimiter = "_"
#
#   ## Detect alert logs
#   # alerts = false


# # Accepts syslog messages following RFC5424 format with transports as per RFC5426, RFC5425, or RFC6587
# [[inputs.syslog]]
#   ## Specify an ip or hostname with port - eg., tcp://localhost:6514, tcp://10.0.0.1:6514
#   ## Protocol, address and port to host the syslog receiver.
#   ## If no host is specified, then localhost is used.
#   ## If no port is specified, 6514 is used (RFC5425#section-4.1).
#   server = "tcp://:6514"
#
#   ## TLS Config
#   # tls_allowed_cacerts = ["/etc/telegraf/ca.pem"]
#   # tls_cert = "/etc/telegraf/cert.pem"
#   # tls_key = "/etc/telegraf/key.pem"
#
#   ## Period between keep alive probes.
#   ## 0 disables keep alive probes.
#   ## Defaults to the OS configuration.
#   ## Only applies to stream sockets (e.g. TCP).
#   # keep_alive_period = "5m"
#
#   ## Maximum number of concurrent connections (default = 0).
#   ## 0 means unlimited.
#   ## Only applies to stream sockets (e.g. TCP).
#   # max_connections = 1024
#
#   ## Read timeout is the maximum time allowed for reading a single message (default = 5s).
#   ## 0 means unlimited.
#   # read_timeout = "5s"
#
#   ## The framing technique with which it is expected that messages are transported (default = "octet-counting").
#   ## Whether the messages come using the octect-counting (RFC5425#section-4.3.1, RFC6587#section-3.4.1),
#   ## or the non-transparent framing technique (RFC6587#section-3.4.2).
#   ## Must be one of "octet-counting", "non-transparent".
#   # framing = "octet-counting"
#
#   ## The trailer to be expected in case of non-transparent framing (default = "LF").
#   ## Must be one of "LF", or "NUL".
#   # trailer = "LF"
#
#   ## Whether to parse in best effort mode or not (default = false).
#   ## By default best effort parsing is off.
#   # best_effort = false
#
#   ## The RFC standard to use for message parsing
#   ## By default RFC5424 is used. RFC3164 only supports UDP transport (no streaming support)
#   ## Must be one of "RFC5424", or "RFC3164".
#   # syslog_standard = "RFC5424"
#
#   ## Character to prepend to SD-PARAMs (default = "_").
#   ## A syslog message can contain multiple parameters and multiple identifiers within structured data section.
#   ## Eg., [id1 name1="val1" name2="val2"][id2 name1="val1" nameA="valA"]
#   ## For each combination a field is created.
#   ## Its name is created concatenating identifier, sdparam_separator, and parameter name.
#   # sdparam_separator = "_"


# # Parse the new lines appended to a file
# [[inputs.tail]]
#   ## File names or a pattern to tail.
#   ## These accept standard unix glob matching rules, but with the addition of
#   ## ** as a "super asterisk". ie:
#   ##   "/var/log/**.log"  -> recursively find all .log files in /var/log
#   ##   "/var/log/*/*.log" -> find all .log files with a parent dir in /var/log
#   ##   "/var/log/apache.log" -> just tail the apache log file
#   ##   "/var/log/log[!1-2]*  -> tail files without 1-2
#   ##   "/var/log/log[^1-2]*  -> identical behavior as above
#   ## See https://github.com/gobwas/glob for more examples
#   ##
#   files = ["/var/mymetrics.out"]
#
#   ## Read file from beginning.
#   # from_beginning = false
#
#   ## Whether file is a named pipe
#   # pipe = false
#
#   ## Method used to watch for file updates.  Can be either "inotify" or "poll".
#   # watch_method = "inotify"
#
#   ## Maximum lines of the file to process that have not yet be written by the
#   ## output.  For best throughput set based on the number of metrics on each
#   ## line and the size of the output's metric_batch_size.
#   # max_undelivered_lines = 1000
#
#   ## Character encoding to use when interpreting the file contents.  Invalid
#   ## characters are replaced using the unicode replacement character.  When set
#   ## to the empty string the data is not decoded to text.
#   ##   ex: character_encoding = "utf-8"
#   ##       character_encoding = "utf-16le"
#   ##       character_encoding = "utf-16be"
#   ##       character_encoding = ""
#   # character_encoding = ""
#
#   ## Data format to consume.
#   ## Each data format has its own unique set of configuration options, read
#   ## more about them here:
#   ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
#   data_format = "influx"
#
#   ## Set the tag that will contain the path of the tailed file. If you don't want this tag, set it to an empty string.
#   # path_tag = "path"
#
#   ## multiline parser/codec
#   ## https://www.elastic.co/guide/en/logstash/2.4/plugins-filters-multiline.html
#   #[inputs.tail.multiline]
#     ## The pattern should be a regexp which matches what you believe to be an
# 	## indicator that the field is part of an event consisting of multiple lines of log data.
#     #pattern = "^\s"
#
#     ## This field must be either "previous" or "next".
# 	## If a line matches the pattern, "previous" indicates that it belongs to the previous line,
# 	## whereas "next" indicates that the line belongs to the next one.
#     #match_which_line = "previous"
#
#     ## The invert_match field can be true or false (defaults to false).
#     ## If true, a message not matching the pattern will constitute a match of the multiline
# 	## filter and the what will be applied. (vice-versa is also true)
#     #invert_match = false
#
#     ## After the specified timeout, this plugin sends a multiline event even if no new pattern
# 	## is found to start a new event. The default timeout is 5s.
#     #timeout = 5s


# # Generic TCP listener
# [[inputs.tcp_listener]]
#   ## DEPRECATED: The 'tcp_listener' plugin is deprecated in version 1.3.0, use 'inputs.socket_listener' instead.
#   # DEPRECATED: the TCP listener plugin has been deprecated in favor of the
#   # socket_listener plugin
#   # see https://github.com/influxdata/telegraf/tree/master/plugins/inputs/socket_listener


# # Generic UDP listener
# [[inputs.udp_listener]]
#   ## DEPRECATED: The 'udp_listener' plugin is deprecated in version 1.3.0, use 'inputs.socket_listener' instead.
#   # DEPRECATED: the TCP listener plugin has been deprecated in favor of the
#   # socket_listener plugin
#   # see https://github.com/influxdata/telegraf/tree/master/plugins/inputs/socket_listener


# # Read metrics from VMware vCenter
# [[inputs.vsphere]]
#   ## List of vCenter URLs to be monitored. These three lines must be uncommented
#   ## and edited for the plugin to work.
#   vcenters = [ "https://vcenter.local/sdk" ]
#   username = "user@corp.local"
#   password = "secret"
#
#   ## VMs
#   ## Typical VM metrics (if omitted or empty, all metrics are collected)
#   # vm_include = [ "/*/vm/**"] # Inventory path to VMs to collect (by default all are collected)
#   # vm_exclude = [] # Inventory paths to exclude
#   vm_metric_include = [
#     "cpu.demand.average",
#     "cpu.idle.summation",
#     "cpu.latency.average",
#     "cpu.readiness.average",
#     "cpu.ready.summation",
#     "cpu.run.summation",
#     "cpu.usagemhz.average",
#     "cpu.used.summation",
#     "cpu.wait.summation",
#     "mem.active.average",
#     "mem.granted.average",
#     "mem.latency.average",
#     "mem.swapin.average",
#     "mem.swapinRate.average",
#     "mem.swapout.average",
#     "mem.swapoutRate.average",
#     "mem.usage.average",
#     "mem.vmmemctl.average",
#     "net.bytesRx.average",
#     "net.bytesTx.average",
#     "net.droppedRx.summation",
#     "net.droppedTx.summation",
#     "net.usage.average",
#     "power.power.average",
#     "virtualDisk.numberReadAveraged.average",
#     "virtualDisk.numberWriteAveraged.average",
#     "virtualDisk.read.average",
#     "virtualDisk.readOIO.latest",
#     "virtualDisk.throughput.usage.average",
#     "virtualDisk.totalReadLatency.average",
#     "virtualDisk.totalWriteLatency.average",
#     "virtualDisk.write.average",
#     "virtualDisk.writeOIO.latest",
#     "sys.uptime.latest",
#   ]
#   # vm_metric_exclude = [] ## Nothing is excluded by default
#   # vm_instances = true ## true by default
#
#   ## Hosts
#   ## Typical host metrics (if omitted or empty, all metrics are collected)
#   # host_include = [ "/*/host/**"] # Inventory path to hosts to collect (by default all are collected)
#   # host_exclude [] # Inventory paths to exclude
#   host_metric_include = [
#     "cpu.coreUtilization.average",
#     "cpu.costop.summation",
#     "cpu.demand.average",
#     "cpu.idle.summation",
#     "cpu.latency.average",
#     "cpu.readiness.average",
#     "cpu.ready.summation",
#     "cpu.swapwait.summation",
#     "cpu.usage.average",
#     "cpu.usagemhz.average",
#     "cpu.used.summation",
#     "cpu.utilization.average",
#     "cpu.wait.summation",
#     "disk.deviceReadLatency.average",
#     "disk.deviceWriteLatency.average",
#     "disk.kernelReadLatency.average",
#     "disk.kernelWriteLatency.average",
#     "disk.numberReadAveraged.average",
#     "disk.numberWriteAveraged.average",
#     "disk.read.average",
#     "disk.totalReadLatency.average",
#     "disk.totalWriteLatency.average",
#     "disk.write.average",
#     "mem.active.average",
#     "mem.latency.average",
#     "mem.state.latest",
#     "mem.swapin.average",
#     "mem.swapinRate.average",
#     "mem.swapout.average",
#     "mem.swapoutRate.average",
#     "mem.totalCapacity.average",
#     "mem.usage.average",
#     "mem.vmmemctl.average",
#     "net.bytesRx.average",
#     "net.bytesTx.average",
#     "net.droppedRx.summation",
#     "net.droppedTx.summation",
#     "net.errorsRx.summation",
#     "net.errorsTx.summation",
#     "net.usage.average",
#     "power.power.average",
#     "storageAdapter.numberReadAveraged.average",
#     "storageAdapter.numberWriteAveraged.average",
#     "storageAdapter.read.average",
#     "storageAdapter.write.average",
#     "sys.uptime.latest",
#   ]
#     ## Collect IP addresses? Valid values are "ipv4" and "ipv6"
#   # ip_addresses = ["ipv6", "ipv4" ]
#
#   # host_metric_exclude = [] ## Nothing excluded by default
#   # host_instances = true ## true by default
#
#
#   ## Clusters
#   # cluster_include = [ "/*/host/**"] # Inventory path to clusters to collect (by default all are collected)
#   # cluster_exclude = [] # Inventory paths to exclude
#   # cluster_metric_include = [] ## if omitted or empty, all metrics are collected
#   # cluster_metric_exclude = [] ## Nothing excluded by default
#   # cluster_instances = false ## false by default
#
#   ## Datastores
#   # datastore_include = [ "/*/datastore/**"] # Inventory path to datastores to collect (by default all are collected)
#   # datastore_exclude = [] # Inventory paths to exclude
#   # datastore_metric_include = [] ## if omitted or empty, all metrics are collected
#   # datastore_metric_exclude = [] ## Nothing excluded by default
#   # datastore_instances = false ## false by default
#
#   ## Datacenters
#   # datacenter_include = [ "/*/host/**"] # Inventory path to clusters to collect (by default all are collected)
#   # datacenter_exclude = [] # Inventory paths to exclude
#   datacenter_metric_include = [] ## if omitted or empty, all metrics are collected
#   datacenter_metric_exclude = [ "*" ] ## Datacenters are not collected by default.
#   # datacenter_instances = false ## false by default
#
#   ## Plugin Settings
#   ## separator character to use for measurement and field names (default: "_")
#   # separator = "_"
#
#   ## number of objects to retrieve per query for realtime resources (vms and hosts)
#   ## set to 64 for vCenter 5.5 and 6.0 (default: 256)
#   # max_query_objects = 256
#
#   ## number of metrics to retrieve per query for non-realtime resources (clusters and datastores)
#   ## set to 64 for vCenter 5.5 and 6.0 (default: 256)
#   # max_query_metrics = 256
#
#   ## number of go routines to use for collection and discovery of objects and metrics
#   # collect_concurrency = 1
#   # discover_concurrency = 1
#
#   ## the interval before (re)discovering objects subject to metrics collection (default: 300s)
#   # object_discovery_interval = "300s"
#
#   ## timeout applies to any of the api request made to vcenter
#   # timeout = "60s"
#
#   ## When set to true, all samples are sent as integers. This makes the output
#   ## data types backwards compatible with Telegraf 1.9 or lower. Normally all
#   ## samples from vCenter, with the exception of percentages, are integer
#   ## values, but under some conditions, some averaging takes place internally in
#   ## the plugin. Setting this flag to "false" will send values as floats to
#   ## preserve the full precision when averaging takes place.
#   # use_int_samples = true
#
#   ## Custom attributes from vCenter can be very useful for queries in order to slice the
#   ## metrics along different dimension and for forming ad-hoc relationships. They are disabled
#   ## by default, since they can add a considerable amount of tags to the resulting metrics. To
#   ## enable, simply set custom_attribute_exclude to [] (empty set) and use custom_attribute_include
#   ## to select the attributes you want to include.
#   ## By default, since they can add a considerable amount of tags to the resulting metrics. To
#   ## enable, simply set custom_attribute_exclude to [] (empty set) and use custom_attribute_include
#   ## to select the attributes you want to include.
#   # custom_attribute_include = []
#   # custom_attribute_exclude = ["*"]
#
#   ## The number of vSphere 5 minute metric collection cycles to look back for non-realtime metrics. In
#   ## some versions (6.7, 7.0 and possible more), certain metrics, such as cluster metrics, may be reported
#   ## with a significant delay (>30min). If this happens, try increasing this number. Please note that increasing
#   ## it too much may cause performance issues.
#   # metric_lookback = 3
#
#   ## Optional SSL Config
#   # ssl_ca = "/path/to/cafile"
#   # ssl_cert = "/path/to/certfile"
#   # ssl_key = "/path/to/keyfile"
#   ## Use SSL but skip chain & host verification
#   # insecure_skip_verify = false
#
#   ## The Historical Interval value must match EXACTLY the interval in the daily
#   # "Interval Duration" found on the VCenter server under Configure > General > Statistics > Statistic intervals
#   # historical_interval = "5m"


# # A Webhooks Event collector
# [[inputs.webhooks]]
#   ## Address and port to host Webhook listener on
#   service_address = ":1619"
#
#   [inputs.webhooks.filestack]
#     path = "/filestack"
#
# 	## HTTP basic auth
# 	#username = ""
# 	#password = ""
#
#   [inputs.webhooks.github]
#     path = "/github"
#     # secret = ""
#
# 	## HTTP basic auth
# 	#username = ""
# 	#password = ""
#
#   [inputs.webhooks.mandrill]
#     path = "/mandrill"
#
# 	## HTTP basic auth
# 	#username = ""
# 	#password = ""
#
#   [inputs.webhooks.rollbar]
#     path = "/rollbar"
#
# 	## HTTP basic auth
# 	#username = ""
# 	#password = ""
#
#   [inputs.webhooks.papertrail]
#     path = "/papertrail"
#
# 	## HTTP basic auth
# 	#username = ""
# 	#password = ""
#
#   [inputs.webhooks.particle]
#     path = "/particle"
#
# 	## HTTP basic auth
# 	#username = ""
# 	#password = ""


# # This plugin implements the Zipkin http server to gather trace and timing data needed to troubleshoot latency problems in microservice architectures.
# [[inputs.zipkin]]
#   # path = "/api/v1/spans" # URL path for span data
#   # port = 9411            # Port on which Telegraf listens
