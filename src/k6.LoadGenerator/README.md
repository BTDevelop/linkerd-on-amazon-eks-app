#### Scripts

docker-compose up -d influxdb grafana

docker-compose run k6 run /scripts/load.js


#### Remove

docker rm -f docker-k6-grafana-influxdb_k6_run_1
docker rm -f docker-k6-grafana-influxdb_grafana_1
docker rm -f docker-k6-grafana-influxdb_influxdb_1
