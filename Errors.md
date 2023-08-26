##### Info:
kafka cluster Id : kfc04ck57qjqj3bapcgn


###### Error while using the example code from the documentation:
```bash
Error: Unsupported value "SASL_SSL" for configuration property "security.protocol": OpenSSL not available at build time

at Producer.Client (/Users/arpitkumar/Desktop/kafka_node/node_modules/node-rdkafka/lib/client.js:54:18)

at new Producer (/Users/arpitkumar/Desktop/kafka_node/node_modules/node-rdkafka/lib/producer.js:75:10)

at Object.<anonymous> (/Users/arpitkumar/Desktop/kafka_node/producer.js:10:18)

at Module._compile (node:internal/modules/cjs/loader:1159:14)

at Module._extensions..js (node:internal/modules/cjs/loader:1213:10)

at Module.load (node:internal/modules/cjs/loader:1037:32)

at Module._load (node:internal/modules/cjs/loader:878:12)

at Function.executeUserEntryPoint [as runMain] (node:internal/modules/run_main:81:12)

at node:internal/main/run_main_module:23:47

  

Node.js v18.11.0
```

- The example code is for an ubuntu setup with older node version, we are using macOS with apple silicon, might be the root
of the issue, as we were already using sasl_ssl security for kafka setup before, also installing openssl and then installing
'node-rdkafka' didn't resolve the issue, further online solutions recommended installing some particular libraries, installing them on macOS however is not a straightforward matter as using brew, using ‘kafkajs’ an npm library for kafka with similar settings worked fine.



```bash
{"level":"ERROR","timestamp":"2022-12-16T06:31:23.825Z","logger":"kafkajs","message":"[Connection] Connection error: connect ETIMEDOUT 3.111.170.135:9091","broker":"rw.kfc04ck57qjqj3bapcgn.at.double.cloud:9091","clientId":"my-app","stack":"Error: connect ETIMEDOUT 3.111.170.135:9091\n    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1159:16)"}
{"level":"ERROR","timestamp":"2022-12-16T06:31:25.066Z","logger":"kafkajs","message":"[Connection] Connection error: connect ETIMEDOUT 3.111.170.135:9091","broker":"rw.kfc04ck57qjqj3bapcgn.at.double.cloud:9091","clientId":"my-app","stack":"Error: connect ETIMEDOUT 3.111.170.135:9091\n    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1159:16)"}
{"level":"ERROR","timestamp":"2022-12-16T06:31:26.644Z","logger":"kafkajs","message":"[Connection] Connection error: connect ETIMEDOUT 3.111.170.135:9091","broker":"rw.kfc04ck57qjqj3bapcgn.at.double.cloud:9091","clientId":"my-app","stack":"Error: connect ETIMEDOUT 3.111.170.135:9091\n    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1159:16)"}
{"level":"ERROR","timestamp":"2022-12-16T06:31:28.635Z","logger":"kafkajs","message":"[Connection] Connection error: connect ETIMEDOUT 3.111.170.135:9091","broker":"rw.kfc04ck57qjqj3bapcgn.at.double.cloud:9091","clientId":"my-app","stack":"Error: connect ETIMEDOUT 3.111.170.135:9091\n    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1159:16)"}
{"level":"ERROR","timestamp":"2022-12-16T06:31:31.897Z","logger":"kafkajs","message":"[Connection] Connection error: connect ETIMEDOUT 3.111.170.135:9091","broker":"rw.kfc04ck57qjqj3bapcgn.at.double.cloud:9091","clientId":"my-app","stack":"Error: connect ETIMEDOUT 3.111.170.135:9091\n    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1159:16)"}
{"level":"ERROR","timestamp":"2022-12-16T06:31:37.462Z","logger":"kafkajs","message":"[Connection] Connection error: connect ETIMEDOUT 3.111.170.135:9091","broker":"rw.kfc04ck57qjqj3bapcgn.at.double.cloud:9091","clientId":"my-app","stack":"Error: connect ETIMEDOUT 3.111.170.135:9091\n    at TCPConnectWrap.afterConnect [as oncomplete] (net.js:1159:16)"}
{"level":"ERROR","timestamp":"2022-12-16T06:32:29.528Z","logger":"kafkajs","message":"[Connection] Connection timeout","broker":"akf-aps1-az1-1.kfc04ck57qjqj3bapcgn.at.double.cloud:9091","clientId":"my-app"}
{"level":"ERROR","timestamp":"2022-12-16T06:32:29.678Z","logger":"kafkajs","message":"[Connection] Connection error: Client network socket disconnected before secure TLS connection was established","broker":"akf-aps1-az1-1.kfc04ck57qjqj3bapcgn.at.double.cloud:9091","clientId":"my-app","stack":"Error: Client network socket disconnected before secure TLS connection was established\n    at connResetException (internal/errors.js:639:14)\n    at TLSSocket.onConnectEnd (_tls_wrap.js:1570:19)\n    at TLSSocket.emit (events.js:412:35)\n    at TLSSocket.emit (domain.js:475:12)\n    at endReadableNT (internal/streams/readable.js:1334:12)\n    at processTicksAndRejections (internal/process/task_queues.js:82:21)"}
{"level":"ERROR","timestamp":"2022-12-16T06:32:29.690Z","logger":"kafkajs","message":"[Connection] Connection error: write after end","broker":"akf-aps1-az1-1.kfc04ck57qjqj3bapcgn.at.double.cloud:9091","clientId":"my-app","stack":"Error [ERR_STREAM_WRITE_AFTER_END]: write after end\n    at new NodeError (internal/errors.js:322:7)\n    at TLSSocket.Writable.write (internal/streams/writable.js:292:11)\n    at Object.sendRequest (/Users/ayush/Workspace/csc-kafka/node_modules/kafkajs/src/network/connection.js:409:27)\n    at SocketRequest.send [as sendRequest] (/Users/ayush/Workspace/csc-kafka/node_modules/kafkajs/src/network/requestQueue/index.js:142:23)\n    at SocketRequest.send (/Users/ayush/Workspace/csc-kafka/node_modules/kafkajs/src/network/requestQueue/socketRequest.js:88:10)\n    at RequestQueue.sendSocketRequest (/Users/ayush/Workspace/csc-kafka/node_modules/kafkajs/src/network/requestQueue/index.js:173:19)\n    at RequestQueue.push (/Users/ayush/Workspace/csc-kafka/node_modules/kafkajs/src/network/requestQueue/index.js:153:12)\n    at /Users/ayush/Workspace/csc-kafka/node_modules/kafkajs/src/network/connection.js:404:29\n    at new Promise (<anonymous>)\n    at sendRequest (/Users/ayush/Workspace/csc-kafka/node_modules/kafkajs/src/network/connection.js:399:14)"}
{"level":"ERROR","timestamp":"2022-12-16T06:32:29.725Z","logger":"kafkajs","message":"[Producer] Failed to send messages: Connection timeout","retryCount":0,"retryTime":325}


Unhandled Rejection at: Promise Promise {
  <rejected> KafkaJSNonRetriableError
    Caused by: KafkaJSConnectionError: Connection timeout
      at Timeout.onTimeout [as _onTimeout] (/Users/ayush/Workspace/csc-kafka/node_modules/kafkajs/src/network/connection.js:223:23)
      at listOnTimeout (internal/timers.js:557:17)
      at processTimers (internal/timers.js:500:7) {
    name: 'KafkaJSNumberOfRetriesExceeded',
    retriable: false,
    helpUrl: undefined,
    cause: KafkaJSConnectionError: Connection timeout
        at Timeout.onTimeout [as _onTimeout] (/Users/ayush/Workspace/csc-kafka/node_modules/kafkajs/src/network/connection.js:223:23)
        at listOnTimeout (internal/timers.js:557:17)
        at processTimers (internal/timers.js:500:7) {
      retriable: true,
      helpUrl: undefined,
      cause: undefined,
      broker: 'rw.kfc04ck57qjqj3bapcgn.at.double.cloud:9091',
      code: undefined
    },
    retryCount: 5,
    retryTime: 10488
  }
} reason: KafkaJSNonRetriableError
  Caused by: KafkaJSConnectionError: Connection timeout
    at Timeout.onTimeout [as _onTimeout] (/Users/ayush/Workspace/csc-kafka/node_modules/kafkajs/src/network/connection.js:223:23)
    at listOnTimeout (internal/timers.js:557:17)
    at processTimers (internal/timers.js:500:7) {
  name: 'KafkaJSNumberOfRetriesExceeded',
  retriable: false,
  helpUrl: undefined,
  cause: KafkaJSConnectionError: Connection timeout
      at Timeout.onTimeout [as _onTimeout] (/Users/ayush/Workspace/csc-kafka/node_modules/kafkajs/src/network/connection.js:223:23)
      at listOnTimeout (internal/timers.js:557:17)
      at processTimers (internal/timers.js:500:7) {
    retriable: true,
    helpUrl: undefined,
    cause: undefined,
    broker: 'rw.kfc04ck57qjqj3bapcgn.at.double.cloud:9091',
    code: undefined
  },
  retryCount: 5,
  retryTime: 10488
}
```

- As seen yesterday the connection worked when using the 'host string', this is relatively new behaviour as the 'connection string' was working fine before, it is possible that the IP CIDR block patch might have introduced this behaviour please look into it. Also while consuming msgs is successful when using the 'host string' for connection, it will be separate for each broker, so it is unclear how the load balancing will happen when each broker will be hit separately.

