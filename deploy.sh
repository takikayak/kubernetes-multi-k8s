docker build -t takikayak/multi-client:latest -t takikayak/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t takikayak/multi-server:latest -t takikayak/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t takikayak/multi-worker:latest -t takikayak/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push takikayak/multi-client:latest
docker push takikayak/multi-server:latest
docker push takikayak/multi-worker:latest
docker push takikayak/multi-client:$SHA
docker push takikayak/multi-server:$SHA
docker push takikayak/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=takikayak/multi-server:$SHA
kubectl set image deployments/client-deployment client=takikayak/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=takikayak/multi-worker:$SHA
