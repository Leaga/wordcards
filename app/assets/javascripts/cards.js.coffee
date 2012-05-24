# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require google_jsapi

google.load('search', '1')
count = 0
lastImage = ''

@lookup = (word) ->
  lookupDefinition(word, $('#card_definition')[0])
  lookupExample(word, $('#card_example')[0])
  lookupTranslation(word, $('#card_translation')[0])
  lookupImages(word);


lookupDefinition = (word, resultContainer) ->
  lookupService("/lookup/definition", word, resultContainer)

lookupExample = (word, resultContainer) ->
  lookupService("/lookup/example", word, resultContainer)

lookupTranslation = (word, resultContainer) ->
  lookupService("/lookup/translation", word, resultContainer)


@addImageLinkToWord = (image) ->
#  $(image).attr("src")
  if lastImage
    transformImage(lastImage, "none")
#    $(lastImage).attr("name", "")
  transformImage(image, "scale(1.1) rotate(-2deg)" )
#  $(image).attr("name", "card[image_src]")
  $("#card_image_src").val($(image).attr("src"))
  console.log($("#card_image_src").val());
  lastImage = image


transformImage = (image, transformationString) ->
  $(image).css("-webkit-transform", transformationString)
  $(image).css("-moz-transform", transformationString)
  $(image).css("-o-transform", transformationString)
  $(image).css("transform", transformationString)


searchComplete = (searcher) ->
  if searcher.results and searcher.results.length > 0
    contentDiv = document.getElementById('google-images-content')
    contentDiv.innerHTML = ''

    results = searcher.results
    printSearch result, contentDiv for result in results

printSearch = (result, contentDiv) ->
  count = count + 1
  newImg = document.createElement('img')
  newImg.setAttribute('id', 'google-image-'+count)
  newImg.setAttribute('class', 'google-image')
#  newImg.src = result.tbUrl
  newImg.src = result.url
  newImg.setAttribute('onclick', 'addImageLinkToWord(this);')
  contentDiv.appendChild(newImg)

lookupImages = (word) ->
  imageSearch = new google.search.ImageSearch()
#  TODO comment out restrictions later
  imageSearch.setRestriction(
    google.search.ImageSearch.IMAGESIZE_MEDIUM
#      google.search.ImageSearch.RESTRICT_RIGHTS,
#      google.search.ImageSearch.RIGHTS_COMMERCIAL_MODIFICATION
  )
  imageSearch.setSearchCompleteCallback(this, searchComplete, [imageSearch])
  imageSearch.execute(word)

lookupService = (url, word, resultContainer) ->
  $.ajax({
    url: url,
    data: {word: word},
    dataType: "json",
    success: (data) -> $(resultContainer).val(data.result)
  });


$ ->
  $("div.field input#card_word").live "keyup", (e) ->
    e.preventDefault()
    e.stopPropagation()
    console.log(e.keyCode)
    if e.keyCode == 13
      $("div.field input#lookup-button").click()
      console.log("click!")

#  $("article.card-thumb").click ->
#    $(this).rotate3Di('flip', 500)
#    $(this).find("div").stop().rotate3Di('flip', 250);












