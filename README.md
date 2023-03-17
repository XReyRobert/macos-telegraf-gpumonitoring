# macos-telegraf-gpumonitoring
macos-telegraf-gpumonitoring


Quickly sharing a tool to get GPU information on intel mac (AMD GPU) and on Apple silicon (more limited)

This tool is used with telegraf to populate an Influxdb bucket to display stats in grafana;


GPU performance statistics are exported using Apple IOKitframework as a JSON. 
Telegraf is configured to invoke gpuPerformanceStatistics and parse the json to ingest all available fields)