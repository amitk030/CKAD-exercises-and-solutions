# Custom Resource Definition

[Custom Resource Definition](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/)
</br>

[Tips and Tricks](https://github.com/amitk030/CKAD-exercises-and-solutions/blob/master/tips_and_tricks.md)

##### For simulated Practice problems visit [KillerCoda](https://killercoda.com/amitk).


1. ### Create a Custom Resource Definition named `BusTicket` in the `ticket.com` API group.

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

2. ### Create a Custom Resource named `my-ticket` of type `BusTicket` in the `default` namespace.

    <details><summary>Solution</summary>
      <p>

      ```bash
      kubectl apply -f - <<EOF
      apiVersion: ticket.com/v1
      kind: BusTicket
      metadata:
        name: my-ticket
      spec:
        from: "New Delhi"
        to: "Mumbai"
        seats: 5
      EOF
      ```
      </p>
    </details>

1. ### Update the `from` value of the `BusTicket` named `my-ticket` in the `default` namespace to newvalue.
  
      <details><summary>Solution</summary>
        <p>
  
        ```bash
        kubectl patch busticket my-ticket --type='json' -p='[{"op": "replace", "path": "/spec/from", "value": "Bangalore"}]'
        ```
        </p>
      </details>