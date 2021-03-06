App.flight_update = App.cable.subscriptions.create('FlightUpdateChannel', {
  connected: function () {
    return alert('connected')
  },
  disconnected: function () {
    return alert('disconnected')
  },
  received: function (data) {
    var $target = $('#flight-list')

    // creation of the div
    var $new_flight_div = $('<div class="column is-one-quarter">')
    var $new_flight_card = $('<div class="card">')
    var $new_flight_card_content = $('<div class="card-content">')
    var $new_flight_p_title = $('<p class="title">')
    var $new_flight_p_subtitle = $('<p class="subtitle">')

    // populating the body inside the div (title and subtitle)
    $new_flight_p_title.text(data.content.from + ' - ' + data.content.to)
    $new_flight_p_subtitle.text(data.content.airline)

    // appending the div into the card structure
    $new_flight_card_content.append($new_flight_p_title)
    $new_flight_card_content.append($new_flight_p_subtitle)
    $new_flight_card.append($new_flight_card_content)
    $new_flight_div.append($new_flight_card)

    // append that to the targeted div (#flight-list)
    $target.append($new_flight_div)
  }
})

// ---
// generated by coffee-script 1.9.2
