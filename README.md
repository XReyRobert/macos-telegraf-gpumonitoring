# macos-telegraf-gpumonitoring
macos-telegraf-gpumonitoring


Quickly sharing a tool to get GPU information on intel mac (AMD GPU) and on Apple silicon (more limited)

This tool is used with telegraf to populate an Influxdb bucket to display stats in grafana;


GPU performance statistics are exported using Apple IOKitframework as a JSON. 
Telegraf is configured to invoke gpuPerformanceStatistics and parse the json to ingest all available fields)
`
[[inputs.execd]]
  command = ["/usr/local/bin/gpuPerformanceStatistics", "IOAccelerator"]
  name_override = "macosgpu"
  signal = "none"
  restart_delay = "10s"
  data_format="json"
  [[outputs.influxdb_v2]]
  urls = ["http://yourinfluxdbserver:8086"]
  [[outputs.influxdb_v2]]
  urls = ["http://yourinfluxdbserver:8086"]
  ## Token for authentication.
  token = "yourtoken"
  ## Organization is the name of the organization you wish to write to; must exist.
  organization = "yourorganisation"
  ## Destination bucket to write into.
  ## Change it but update the dashboard accordingly (hint: find/replace into the grafana dashboard  json before importing it)
  bucket = "XRRMonitoring"
`

