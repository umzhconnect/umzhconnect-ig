# Setup for test call with hapi-fhir

add this to your /etc/hosts:

127.0.0.1 fulfiller.example.org
127.0.0.1 placer.example.org

Then run:
docker compose up -d

```http
GET http://fulfiller.example.org/fhir/metadata
```

```http
GET http://placer.example.org/fhir/metadata
```

