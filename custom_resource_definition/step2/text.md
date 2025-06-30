### Create a Custom Resource named `my-ticket` of type `BusTicket` in the `default` namespace, from `New Delhi`, to `Mumbai` and for `5` seats.

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