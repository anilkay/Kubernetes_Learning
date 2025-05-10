#install
kubectl create ns sonarqube

kubectl create secret generic sonarqube-monitoring-passcode   -n sonarqube   --from-literal=monitoring-passcode="$sonarMonitoringPassCode"


kubectl create secret generic sonar-postgres-secret \
  -n sonarqube \
  --from-literal=postgresql-password="$sonarPostgresPass"

helm upgrade --install sonarqube sonarqube/sonarqube   -n sonarqube -f sonar_values.yaml
