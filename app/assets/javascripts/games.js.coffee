updateBoard = (response) ->
  board = response.board
  turn = response.turn
  yourPlayer = $("#player").attr("data-your-player")
  r = 0
  c = 0
  for row in board
    c = 0
    for col in row
      new_dot = $("span.square[data-col-no="+c+"][data-row-no="+r+"]")
      color = ""
      if col == 1
        color = "blue"
      if col == 2
        color = "red"
      $(new_dot).addClass(color)
      c++
    r++
  debugger
  if yourPlayer == turn.toString()
    $("#turn").attr("data-your-turn", "true")
    $("#turn").text("It's your turn!")

$ ->
  $("span.square").click () ->
    col_no = $(@).data('col-no')
    $.ajax
      method: "PUT"
      dataType: "json"
      contentType: "application/json"
      data: JSON.stringify({"col": col_no})
      url: $(@).data('url')
      success: (response) ->
        new_dot = $("span.square[data-col-no="+response.col_played+"][data-row-no="+response.row_played+"]")
        if response.player_played == 1
          color = "blue"
        if response.player_played == 2
          color = "red"
        $(new_dot).addClass(color)
        $("#turn").text("Waiting for rival to play...")

  window.setInterval (->
    #yourTurn = $("#turn").attr("data-your-turn")
    #if yourTurn == "false"
    $.ajax
      method: "GET"
      url: "get_board"
      success: (response) ->
        updateBoard(response)
    return
  ), 5000

