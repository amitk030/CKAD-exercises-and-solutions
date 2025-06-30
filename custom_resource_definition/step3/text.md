### Update the `from` value of the `BusTicket` named `my-ticket` in the `default` namespace to `Bangalore`.
  
<details><summary>Solution</summary>
  <p>

  ```bash
  kubectl patch busticket my-ticket --type='json' -p='[{"op": "replace", "path": "/spec/from", "value": "Bangalore"}]'
  ```
  </p>
</details>