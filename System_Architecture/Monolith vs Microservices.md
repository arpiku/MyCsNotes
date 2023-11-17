# Understanding Monolith vs Mircoservice, architecture
[[Load Balancer]]

![[Microservices/img/snapshot.jpg]]

## Issues :
1. Inflexible
2. Slow deployment times, this is due to interdependencies of the files, one change might break the whole thing.
3. Unscalable (Yes and No)
4. Large and complex application
5. Unreliable

## Microservices
In microservices architecture the application is broken down into small components that communicate using [[API]]s,:
1. Each ms is responsible for it's data structure and what it does with it, all the other things are handled using api interaction between the different microservcies.
![[Microservices/img/snapshot_2.jpg]]

1. In MS, loosely coupled means that one service is not highly dependent on the other service to function properly.
2. Language Neutral
3. Small focused.
4. Bounded context.