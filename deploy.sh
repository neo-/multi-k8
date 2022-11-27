docker build -t naveejr/multi-client:latest -t naveejr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t naveejr/multi-server:latest -t naveejr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t naveejr/multi-worker:latest -t naveejr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push naveejr/multi-client:latest
docker push naveejr/multi-server:latest
docker push naveejr/multi-worker:latest
docker push naveejr/multi-client:$SHA
docker push naveejr/multi-server:$SHA
docker push naveejr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=naveejr/multi-client:$SHA
kubectl set image deployments/server-deployment server=naveejr/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=naveejr/multi-worker:$SHA
