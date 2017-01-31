import {Socket} from "phoenix"

class App {

  static init(){
    let socket = new Socket("/socket", {params: {token: window.userToken}})

    socket.connect({user_id: "123"})
    var $messages  = $("#messages")
    var $input     = $("#body")
    var $username  = $("#author")
    var $button    = $("#submit")

    var chan = socket.channel("room:lobby", {})
    chan.join()

    $input.off("keypress").on("keypress", e => {
      if (e.keyCode == 13) {
        chan.push("new:msg", {user: $username.val(), body: $input.val()})
        $input.val("")
      }
    })

    $button.on("click", e => {
      chan.push("new:msg", {user: $username.val(), body: $input.val()})
      $input.val("")
    })

    chan.on("new:msg", msg => {
      $messages.append(this.messageTemplate(msg))
      scrollTo(0, document.body.scrollHeight)
    })

    chan.on("user:entered", msg => {
      var username = this.sanitize(msg.user || "anonymous")
      $messages.append(`<br/><i>[${username} entered]</i>`)
    })
  }

  static sanitize(html){ return $("<div/>").text(html).html() }

  static messageTemplate(msg){
    let username = this.sanitize(msg.user || "anonymous")
    let body     = this.sanitize(msg.body)

    return(`<p><a href='#'>[${username}]</a>&nbsp; ${body}</p>`)
  }

}

$( () => App.init() )

export default App