import PlacesAutocomplete from "stimulus-places-autocomplete"

class AutoplacesController extends PlacesAutocomplete {

  static dispatchEvent() {
    const event = new Event('google-maps-callback', { bubbles: true, cancelable: true })
    window.dispatchEvent(event)
  }

  setAddressComponents (address) {
    super.setAddressComponents(address);
    if (this.hasAddressTarget) this.addressTarget.value = [address.street_number, address.route].join(' ') || ''
  }

  get autocompleteOptions () {
    return {
      componentRestrictions: { country: ["us"] },
      fields: ['address_components'],
      types: ['address']
    }
  }
}

window.AutoplacesController = AutoplacesController
export default AutoplacesController
