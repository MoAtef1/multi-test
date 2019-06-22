docker build -t moatef/multi-server:latest -t moatef/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t moatef/multi-client:latest -t moatef/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t moatef/multi-worker:latest -t moatef/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push moatef/multi-server:latest 
docker push moatef/multi-client:latest 
docker push moatef/multi-worker:latest 
docker push moatef/multi-server:$SHA
docker push moatef/multi-client:$SHA
docker push moatef/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=moatef/multi-server:$SHA
kubectl set image deployments/client-deployment client=moatef/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=moatef/multi-worker:$SHA

