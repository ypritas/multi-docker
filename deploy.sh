docker build -t ypritas/multi-client:latest -t ypritas/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ypritas/multi-server:latest -t ypritas/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ypritas/multi-worker:latest -t ypritas/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ypritas/multi-client:latest
docker push ypritas/multi-server:latest
docker push ypritas/multi-worker:latest

docker push ypritas/multi-client:$SHA
docker push ypritas/multi-server:$SHA
docker push ypritas/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ypritas/multi-server:$SHA
kubectl set image deployments/client-deployment server=ypritas/multi-client:$SHA
kubectl set image deployments/worker-deployment server=ypritas/multi-worker:$SHA