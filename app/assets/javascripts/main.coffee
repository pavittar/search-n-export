jQuery ->
  csvStorageKey = 'exportToCSVAsync'
  # ===========================================================================

  $('.export-to-csv-async').submit (e)->
    e.preventDefault()
    alert('Export Started')

    if !localStorage.getItem(csvStorageKey)
      localStorage.setItem(csvStorageKey, '[]')

    $.ajax(
      url: $(this).attr('action')
      type: 'POST'
      dataType: 'json'
      data: $(this).serialize()

      success: (response)->
        items = JSON.parse(localStorage.getItem(csvStorageKey))
        items.push(response.id)
        localStorage.setItem(csvStorageKey, JSON.stringify(items))

        pollExportCSVStatusFor(response.id)
      error: ->
        alert('Export Failed')
    )
  # ===========================================================================

  pollExportCSVStatusFor = (id)->
    $.get("/downloads/#{id}.json", (response)->
      if response.status == 'completed'
        items = JSON.parse(localStorage.getItem(csvStorageKey))
        items.splice( $.inArray(response.id, items), 1 )
        localStorage.setItem(csvStorageKey, JSON.stringify(items))

        alert('CSV Ready for download')
      else
        setTimeout (->
          pollExportCSVStatusFor(id)
        ), 3000
    )
  # ===========================================================================

  getExportCSVStatus = ->
    items = JSON.parse(localStorage.getItem(csvStorageKey))
    items.forEach (id)->
      pollExportCSVStatusFor(id)

  getExportCSVStatus()