# A grouping of some useful functions

# Run a director server, mounting the log directory onto /home/director/logs
# If there are google application credentials then use them
director() {
    docker run \
	   --rm \
	   --mount "type=volume,source=db,target=/home/director/db" \
	   --mount "type=bind,source=${SERVER_LOG_DIR:?},target=/home/director/logs" \
	   ${GOOGLE_APPLICATION_CREDENTIALS:+--mount "type=bind,source=${GOOGLE_APPLICATION_CREDENTIALS},target=${GOOGLE_APPLICATION_CREDENTIALS}"} \
	   ${GOOGLE_APPLICATION_CREDENTIALS:+--env GOOGLE_APPLICATION_CREDENTIALS} \
	   --name director \
	   --network director-network \
	   -p 7189:7189 \
	   tobyhferguson/cloudera-director:server_latest
}

# Run a client, copying across the AWS envars as necessary
client() {
    docker run -it \
	   -e AWS_ACCESS_KEY_ID \
	   -e AWS_SECRET_ACCESS_KEY \
	   --mount "type=bind,source=${SSH_KEY_PATH:?},target=${SSH_KEY_PATH:?}" \
	   -e SSH_KEY_PATH \
	   -v ${PWD}:/project \
	   --mount "type=bind,source=${CLIENT_LOG_DIR:?},target=/home/director/logs" \
	   --network director-network \
	   tobyhferguson/cloudera-director:client_6.0.0 \
	   ${1:?'No function name provided'}-remote ${2:?'No conf file provided'} \
	   --lp.remote.username=admin \
	   --lp.remote.password=admin \
	   --lp.remote.hostAndPort=director
}
validate() { client ${FUNCNAME[0]} ${1:?'No conf file provided'} ;}
bootstrap() { client ${FUNCNAME[0]} ${1:?'No conf file provided'} ;}
terminate() { client ${FUNCNAME[0]} ${1:?'No conf file provided'} ;}
convert()  { client ${FUNCNAME[0]} ${1:?'No conf file provided'} ;}

