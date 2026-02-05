# Setup for test call with hapi-fhir

add this to your /etc/hosts:

127.0.0.1 hospitalf.example.org
127.0.0.1 hospitalp.example.org

Then run:
docker compose up -d

```http
GET http://hospitalf.example.org/fhir/metadata
```

```http
GET http://hospitalp.example.org/fhir/metadata
```

