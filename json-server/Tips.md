## Tips 

alias

```
now alias <deployment URL> <domain>
now alias json-server-mrvmcadtxg.now.sh animalish.now.sh 
```

inspect 

```
now inspect animalish.now.sh
```

scaling

```
"scale": {
  "sfo1": {
    "min": 1,
    "max": 1
  }
}

now scale animalish.now.sh sfo 1 3
now scale animalish.now.sh sfo 1
now scale animalish.now.sh 1
```

```
now dns
```


```

```

botも作れるのか

- https://zeit.co/docs/v1/getting-started/scaling/
- https://zeit.co/docs/v2/deployments/configuration/
- https://zeit.co/docs/v2/domains-and-aliases/zero-downtime-domain-migration/
- https://zeit.co/docs/v2/routing/headers/
- https://zeit.co/docs/v2/routing/caching/
- https://spectrum.chat/zeit/now/scaling-instances~895ea168-7ff2-4317-961e-914c510035d0