/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import 'babel-polyfill'
import Elm from '../Main'
window.newText = "Ports working!!"

const init = async () => {
  const response = await fetch('/team_members.json')
  const json = await response.json()

  const target = document.createElement('div')
  document.body.appendChild(target)
  const app = Elm.Main.embed(target, { text: 'Elminess' })
  app.ports.newText.send(JSON.stringify(json))
}

document.addEventListener('DOMContentLoaded', init)
