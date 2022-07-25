import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "modal", "roundsContainer" ]

  connect() {
    let modalElement = this.modalTarget
    let modal = new bootstrap.Modal(modalElement)
    modal.show()
  }

  addRound(e) {
    e.preventDefault()

    let container = this.roundsContainerTarget
    let id = Date.now()
    console.log(container)

    let newFundingRoundHTML = `
    <hr class="m-2">
    <div class="input-group input-group-sm mb-1">
      <span class="input-group-text" id="inputGroup-sizing-sm">Type</span>
      <input class="form-control" type="text" value="" name="company[funding_rounds_attributes][${id}][funding_round_type]" id="company_funding_rounds_attributes_0_funding_round_type">
    </div>
    <div class="input-group input-group-sm mb-1">
      <span class="input-group-text">Date</span>
      <input class="form-control" type="date" value="" name="company[funding_rounds_attributes][${id}][funded_date]" id="company_funding_rounds_attributes_0_funded_date">
    </div>
    <div class="input-group input-group-sm mb-1">
      <span class="input-group-text">Amount</span>
      <input class="form-control" type="text" value="" name="company[funding_rounds_attributes][${id}][funded_usd]" id="company_funding_rounds_attributes_0_funded_usd">
    </div>`

    container.innerHTML += newFundingRoundHTML

    return false
  }
}
