### Create a Custom Resource Definition named `BusTicket` in the `ticket.com` API group. It has 3 fields: `from`, `to`, and `seats`. The `from` and `to` fields are strings, and the `seats` field is an integer. The CRD should be namespaced.

<details><summary>Solution</summary>
  <p>

  ```bash
  apiVersion: apiextensions.k8s.io/v1
  kind: CustomResourceDefinition
  metadata:
    name: bustickets.ticket.com
  spec:
    group: ticket.com
    versions:
      - name: v1
        served: true
        storage: true
        schema:
          openAPIV3Schema:
            type: object
            properties:
              spec:
                type: object
                properties:
                  from:
                    type: string
                  to:
                    type: string
                  seats:
                    type: integer
    scope: Namespaced
    names:
      plural: bustickets
      singular: busticket
      kind: BusTicket
      shortNames:
      - bt
  ```
  </p>
</details>