$(document).ready(function() {

  function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
      results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    var result = decodeURIComponent(results[2].replace(/\+/g, " "));
    return result
  }

  function init() {
    var fromSearch = getParameterByName("from_search")
    var urlPath = document.location.href.replace("?from_search=true","")
    window.history.pushState({},"", urlPath);
    var openTo = getParameterByName("open_to")


    if (openTo) {
      $('.type-' + openTo).click()
    }

    //$('.general-info-more').on("click", function(e) {
      //e.preventDefault()
      //if(fromSearch) {
        //window.history.go(-2)
      //}
    //})
  }

  init()
})

