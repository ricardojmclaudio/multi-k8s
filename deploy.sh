docker build -t ricardojmclaudio/multi-client:latest -t ricardojmclaudio/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ricardojmclaudio/multi-server:latest -t ricardojmclaudio/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ricardojmclaudio/multi-worker:latest -t ricardojmclaudio/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ricardojmclaudio/multi-client:latest
docker push ricardojmclaudio/multi-server:latest
docker push ricardojmclaudio/multi-worker:latest

docker push ricardojmclaudio/multi-client:$SHA
docker push ricardojmclaudio/multi-server:$SHA
docker push ricardojmclaudio/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ricardojmclaudio/multi-server:$SHA
kubectl set image deployments/client-deployment client=ricardojmclaudio/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ricardojmclaudio/multi-worker:$SHA