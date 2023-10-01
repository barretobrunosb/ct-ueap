library(tidyverse)
library(sf)
library(shiny)
library(leaflet)
library(leaflet.extras)
library(sp)
library(rgdal)
library(magrittr)
library(htmlwidgets)
library(leafpop)
library(imager)


# Loading required shapefiles and images
areas <- read_sf("raw_data/ctueap_areas_final.shp")
bposte <- read_sf("raw_data/bposte.shp")
ceramica <- read_sf("raw_data/ceramica.shp")
litico <- read_sf("raw_data/litico.shp")
laterita <- read_sf("raw_data/laterita.shp")
argila <- read_sf("raw_data/argila.shp")
carvao <- read_sf("raw_data/carvao.shp")
fossa <- read_sf("raw_data/fossa.shp")
fogueira <- read_sf("raw_data/fogueira.shp")
bolsao <- read_sf("raw_data/bolsao.shp")
AnomNat <- read_sf("raw_data/AnomNat.shp")
agua <- read_sf("raw_data/agua.shp")
curvas <- read_sf("raw_data/curvas.shp")
ucs <- read_sf("raw_data/ucs.shp")
estacoes <- read_sf("raw_data/estacoes.shp")
tradagens <- read_sf("raw_data/tradagens.shp")
centroids_estruturas <- read_sf("raw_data/centroids_estruturas.shp")
est7 <- fossa[fossa$Estrutura == '7',]
est8 <- fossa[fossa$Estrutura == '8',]
est44 <- fossa[fossa$Estrutura == '44',]
est210 <- fossa[fossa$Estrutura == '210',]
trad_icon <- "img/points.png"
estations <- "img/red-point.png"
est7_img <- "img/7.jpg"
est8_img <- "img/8.gif"
est44_img <- "img/44.jpg"
est210_img <- "img/210.jpg"


#Loading the centroid points for popUp
# centroids_comlink <- read_sf("raw_data/centroids_comlink.shp")
# centroids_semlink <- read_sf("raw_data/centroids_semlink.shp")
# bposte_centroids <- read_sf("raw_data/bposte_centroids.shp")

#Creating the popups
popupArea <- paste(
  areas$Nome, "<br>",
  "Extensão:", areas$Area, "m²", "<br>")

#Popup para mostrar quando pesquisa de todas as estruturas
infoPopup_Centroids <- paste(
    url = paste('<b><a href= ', centroids_estruturas$link, '>', 'Clique aqui para mais informações</a></b>', "<br>"),
  "<b>Estrutura:</b>",
  centroids_estruturas$Estrutura, "<br>",
  "<b>Tipo:</b>",
  centroids_estruturas$Tipo, "<br>",
  "<b>Escavado?</b>",
  centroids_estruturas$Escavacao, "<br>",
  "<b>Profundidade Máxima:</b>", centroids_estruturas$Prof_max, "cm", "<br>",
  "<b>Profundidade Mínima:</b>", centroids_estruturas$Prof_min, "cm", "<br>")

# #Popup para mostrar quando pesquisa de todas as estruturas (sem link)
# infoPopup_Centroids2 <- paste(
#   centroids_estruturas$Estrutura, "<br>",
#   "<b>Tipo:</b>",
#   centroids_estruturas$Tipo, "<br>",
#   "<b>Escavado?</b>",
#   centroids_estruturas$Escavacao, "<br>",
#   "<b>Profundidade Máxima:</b>", centroids_estruturas$Prof_max, "cm", "<br>",
#   "<b>Profundidade Mínima:</b>", centroids_estruturas$Prof_min, "cm", "<br>")

# #Popup para mostrar quando pesquisa de estruturas com link de página
# infoPopup_CentroidsComLink <- paste(
#   url = paste('<b><a href= ', centroids_comlink$link, '>', 'Clique aqui para mais infos</a></b>', "<br>"),
#   "<b>Estrutura:</b>",
#   centroids_comlink$Estrutura, "<br>",
#   "<b>Tipo:</b>",
#   centroids_comlink$Tipo, "<br>",
#   "<b>Escavado?</b>",
#   centroids_comlink$Escavacao, "<br>",
#   "<b>Profundidade Máxima:</b>", centroids_comlink$Prof_max, "cm", "<br>",
#   "<b>Profundidade Mínima:</b>", centroids_comlink$Prof_min, "cm", "<br>")

# #Popup para mostrar quando pesquisa de estruturas sem link de página
# infoPopup_CentroidsSemLink <- paste(
#   "<b>Estrutura:</b>",
#   centroids_semlink$Estrutura, "<br>",
#   "<b>Tipo:</b>",
#   centroids_semlink$Tipo, "<br>",
#   "<b>Escavado?</b>",
#   centroids_semlink$Escavacao, "<br>",
#   "<b>Profundidade Máxima:</b>", centroids_semlink$Prof_max, "cm", "<br>",
#   "<b>Profundidade Mínima:</b>", centroids_semlink$Prof_min, "cm", "<br>")

#Popup para mostrar quando clicar sobre os buracos de poste
infoPopupBPoste <- paste(
  url = paste('<b><a href= ', bposte$link, '>', 'Clique aqui para mais informações</a></b>', "<br>"),
  "<b>Estrutura:</b>",
  bposte$Estrutura, "<br>",
  "<b>Tipo:</b>",
  bposte$Tipo, "<br>",
  "<b>Escavado?</b>",
  bposte$Escavacao, "<br>",
  "<b>Profundidade Máxima:</b>", bposte$Prof_max, "cm", "<br>",
  "<b>Profundidade Mínima:</b>", bposte$Prof_min, "cm", "<br>")


#Popup para mostrar quando clicar sobre as ceramicas
infoPopupCeramica <- paste(
  url = paste('<b><a href= ', ceramica$link, '>', 'Clique aqui para mais informações</a></b>', "<br>"),
  "<b>Estrutura:</b>",
  ceramica$Estrutura, "<br>")

#Popup para mostrar quando clicar sobre as lateritas
infoPopupLaterita <- paste(
  url = paste('<b><a href= ', laterita$link, '>', 'Clique aqui para mais informações</a></b>', "<br>"),
  "<b>Estrutura:</b>",
  laterita$Estrutura, "<br>")
  

#Popup para mostrar quando clicar sobre as fogueiras



#Popup para mostrar quando clicar sobre as fossas
infoPopupFossa <- paste(
  url = paste('<b><a href= ', fossa$link, '>', 'Clique aqui para mais informações</a></b>', "<br>"),
  "<b>Estrutura:</b>",
  fossa$Estrutura, "<br>",
  "<b>Tipo:</b>",
  fossa$Tipo, "<br>",
  "<b>Escavado?</b>",
  fossa$Escavacao, "<br>",
  "<b>Profundidade Máxima:</b>", fossa$Prof_max, "cm", "<br>",
  "<b>Profundidade Mínima:</b>", fossa$Prof_min, "cm", "<br>")


#Popup para mostrar quando clicar sobre os bolsões



#Popup para mostrar quando clicar sobre a cerâmica



#Popup para mostrar quando clicar sobre a laterita



#Popup para mostrar quando clicar sobre a lítico



#Popup para mostrar quando clicar sobre a argila queimada


#### ----------  MAPA ----------  ####


#Initial map with base layers
ctueapMap <- leaflet() %>% 
  setView(lng = -51.082147, lat = -0.033773, zoom = 19) %>% #Setting up the zoom settings
  addMiniMap(position = "bottomright") %>%
  

#### CAMADAS DO MAPA ####   
   
  addPolylines(
    data = curvas,
    color = "black",
    opacity = 1,
    weight = 1,
    label = paste("Altitude:", curvas$Contour, "m"),
    labelOptions = labelOptions(
      textsize = "12px",
      style = list(
        "font-weight" = "bold",
        padding = "5px")
    ),
    highlight = highlightOptions(
      color = "yellow",
      weight = 3,
      fillOpacity = .9,
      bringToFront = FALSE
    ),
    group = "Curvas de Nível") %>% 
  
  addPolygons(
    data = agua,
    color = "black",
    stroke = TRUE,
    fillColor = "lightblue",
    opacity = 1,
    fillOpacity = 1,
    weight = 1,
    label = "Massa D'água",
    labelOptions = labelOptions(
      textsize = "12px",
      style = list(
        "font-weight" = "bold",
        padding = "5px")
    ),
    group = "Hidrografia") %>% 
  
  addCircles(data = centroids_estruturas,
             group = "Centroids",
             lat = ~lat,
             lng = ~long,
             weight = 1,
             radius = 0.01,
             color = alpha("black", 0.0),
             fillColor = alpha("black", 0.0),
             label = paste("EST", centroids_estruturas$Estrutura),
             labelOptions = labelOptions(
               textsize = "12px",
               style = list(
                 "font-weight" = "bold",
                 padding = "5px")
             ), popup = infoPopup_Centroids
             ) %>% 
  
  addPolygons(
    data = areas,
    color = "black",
    stroke = TRUE,
    fillColor = "white",
    opacity = 1,
    fillOpacity = 1,
    weight = .9,
    group = "Áreas Escavadas",
    label = areas$Nome,
    labelOptions = labelOptions(
      textsize = "12px",
      style = list(
        "font-weight" = "bold",
        padding = "5px")
    ),
    popup = popupArea,
    highlight = highlightOptions(
      color = "yellow",
      weight = 3,
      fillOpacity = .9,
      bringToFront = FALSE),
  ) %>% 
  
  addPolygons(
    data = AnomNat,
    color = "black",
    stroke = TRUE,
    fillColor = "#DCDCDC",
    opacity = 1,
    fillOpacity = 1,
    weight = .9,
    group = "Anomalia Natural",
    label = paste("Estrutura", AnomNat$Estrutura, " ", "(Anomalia Natural)"),
    labelOptions = labelOptions(
      textsize = "12px",
      style = list(
        "font-weight" = "bold",
        padding = "5px")
    ),
    highlight = highlightOptions(
      color = "yellow",
      weight = 3,
      fillOpacity = .9,
      bringToFront = FALSE
    ),
  ) %>% 
  
    addPolygons(
    data = fossa,
    color = "black",
    stroke = TRUE,
    fillColor = "#ffb100",
    opacity = 1,
    fillOpacity = 1,
    weight = .9,
    group = "Fossa/Bolsão/Poço",
    label = paste("Estrutura", fossa$Estrutura, " ", "(Fossa)"),
    labelOptions = labelOptions(
      textsize = "12px",
      style = list(
        "font-weight" = "bold",
        padding = "5px")
    ),
    highlight = highlightOptions(
      color = "yellow",
      weight = 3,
      fillOpacity = .9,
      bringToFront = FALSE
    ), popup = infoPopupFossa
  ) %>% 
  
  addPolygons(
    data = est7,
    color = alpha("black", 0.0),
    stroke = TRUE,
    fillColor = alpha("#ffb100", 0.0),
    opacity = 1,
    fillOpacity = 1,
    weight = .9,
    group = "Est7",
    label = paste("Estrutura", est7$Estrutura, " ", "(Fossa)"),
    labelOptions = labelOptions(
      textsize = "12px",
      style = list(
        "font-weight" = "bold",
        padding = "5px")
    ),
    highlight = highlightOptions(
      color = "yellow",
      weight = 3,
      fillOpacity = .9,
      bringToFront = FALSE
    )
  ) %>% 
  
  addPolygons(
    data = est8,
    color = alpha("black", 0.0),
    stroke = TRUE,
    fillColor = alpha("#ffb100", 0.0),
    opacity = 1,
    fillOpacity = 1,
    weight = .9,
    group = "Est8",
    label = paste("Estrutura", est8$Estrutura, " ", "(Fossa)"),
    labelOptions = labelOptions(
      textsize = "12px",
      style = list(
        "font-weight" = "bold",
        padding = "5px")
    ),
    highlight = highlightOptions(
      color = "yellow",
      weight = 3,
      fillOpacity = .9,
      bringToFront = FALSE
    ),
  ) %>% 
  
  addPolygons(
    data = est44,
    color = alpha("black", 0.0),
    stroke = TRUE,
    fillColor = alpha("#ffb100", 0.0),
    opacity = 1,
    fillOpacity = 1,
    weight = .9,
    group = "Est44",
    label = paste("Estrutura", est44$Estrutura, " ", "(Fossa)"),
    labelOptions = labelOptions(
      textsize = "12px",
      style = list(
        "font-weight" = "bold",
        padding = "5px")
    ),
    highlight = highlightOptions(
      color = "yellow",
      weight = 3,
      fillOpacity = .9,
      bringToFront = FALSE
    ),
  ) %>% 
  
  addPolygons(
    data = est210,
    color = alpha("black", 0.0),
    stroke = TRUE,
    fillColor = alpha("#ffb100", 0.0),
    opacity = 1,
    fillOpacity = 1,
    weight = .9,
    group = "Est210",
    label = paste("Estrutura", est210$Estrutura, " ", "(Fossa)"),
    labelOptions = labelOptions(
      textsize = "12px",
      style = list(
        "font-weight" = "bold",
        padding = "5px")
    ),
    highlight = highlightOptions(
      color = "yellow",
      weight = 3,
      fillOpacity = .9,
      bringToFront = FALSE
    ),
  ) %>% 
  
  addPolygons(
    data = bolsao,
    color = "black",
    stroke = TRUE,
    fillColor = "#DEB887",
    opacity = 1,
    fillOpacity = 1,
    weight = .9,
    group = "Fossa/Bolsão/Poço",
    label = paste("Estrutura", bolsao$Estrutura, " ", "(Bolsão)"),
    labelOptions = labelOptions(
      textsize = "12px",
      style = list(
        "font-weight" = "bold",
        padding = "5px")
    ),
    highlight = highlightOptions(color = "yellow", weight = 3, fillOpacity = .9, bringToFront = FALSE),
  ) %>% 
  
  addPolygons(
    data = fogueira,
    color = "black",
    stroke = TRUE,
    fillColor = "#fe0000",
    opacity = 1,
    fillOpacity = 1,
    weight = .9,
    group = "Fogueira",
    label = paste("Estrutura", fogueira$Estrutura, " ", "(Fogueira)"),
    labelOptions = labelOptions(
      textsize = "12px",
      style = list(
        "font-weight" = "bold",
        padding = "5px")
    ),
    highlight = highlightOptions(color = "yellow", weight = 3, fillOpacity = .9, bringToFront = FALSE),
  ) %>% 
  
  addPolygons(
    data = bposte,
    color = "white",
    stroke = TRUE,
    fillColor = "black",
    opacity = 1,
    fillOpacity = 1,
    weight = 1.5,
    group = "Buraco de Poste",
    label = paste("Estrutura", bposte$Estrutura, " ", "(Buraco de Poste)"),
    labelOptions = labelOptions(
      textsize = "12px",
      style = list(
        "font-weight" = "bold",
        padding = "5px")
    ),
    highlight = highlightOptions(color = "yellow", weight = 3, bringToFront = FALSE),
    popup = infoPopupBPoste
  ) %>% 
  
  addPolygons(
    data = argila,
    color = "black",
    stroke = TRUE,
    fillColor = "#ff4601",
    opacity = 1,
    fillOpacity = 1,
    weight = .9,
    group = "Artefatos",
    label = paste("Estrutura", argila$Estrutura, " ", "(Argila Queimada)"),
    labelOptions = labelOptions(
      textsize = "12px",
      style = list(
        "font-weight" = "bold",
        padding = "5px")
    ),
    highlight = highlightOptions(color = "yellow", weight = 3, fillOpacity = .9, bringToFront = TRUE),
  ) %>% 
  
   addPolygons(
    data = ceramica,
    color = "black",
    stroke = TRUE,
    fillColor = "#8B4513",
    opacity = 1,
    fillOpacity = 1,
    weight = .9,
    group = "Artefatos",
    label = paste("Estrutura", ceramica$Estrutura, " ", "(Cerâmica)"),
    labelOptions = labelOptions(
      textsize = "12px",
      style = list(
        "font-weight" = "bold",
        padding = "5px")
    ), popup = infoPopupCeramica,
    highlight = highlightOptions(color = "yellow", weight = 3, fillOpacity = .9, bringToFront = FALSE),
  ) %>% 
  
  addPolygons(
    data = litico,
    color = "black",
    stroke = TRUE,
    fillColor = "green",
    opacity = 1,
    fillOpacity = 1,
    weight = .9,
    group = "Artefatos",
    label = paste("Estrutura", litico$Estrutura, " ", "(Lítico)"),
    labelOptions = labelOptions(
      textsize = "12px",
      style = list(
        "font-weight" = "bold",
        padding = "5px")
    ),
    highlight = highlightOptions(color = "yellow", weight = 3, fillOpacity = .9, bringToFront = TRUE),
  ) %>% 
  
  addPolygons(
    data = laterita,
    color = "black",
    stroke = TRUE,
    fillColor = "#8B008B",
    opacity = 1,
    fillOpacity = 1,
    weight = .9,
    group = "Artefatos",
    label = paste("Estrutura", laterita$Estrutura, " ", "(Laterita)"),
    labelOptions = labelOptions(
      textsize = "12px",
      style = list(
        "font-weight" = "bold",
        padding = "5px")
    ), popup = infoPopupLaterita,
    highlight = highlightOptions(color = "yellow", weight = 3, fillOpacity = .9, bringToFront = TRUE),
  ) %>% 
  
  addPolygons(
    data = carvao,
    color = "black",
    stroke = TRUE,
    fillColor = "#363636",
    opacity = 1,
    fillOpacity = 1,
    weight = .9,
    group = "Artefatos",
    label = paste("Estrutura", carvao$Estrutura, " ", "(Carvão)"),
    labelOptions = labelOptions(
      textsize = "12px",
      style = list(
        "font-weight" = "bold",
        padding = "5px")
    ),
    highlight = highlightOptions(color = "yellow", weight = 3, fillOpacity = .9, bringToFront = TRUE),
  ) %>% 
  
  addCircles(data = ucs,
             group = "Unidades de Coleta",
             lat = ~lat,
             lng = ~long,
             weight = 1,
             radius = 0.03,
             color = "black",
             fillColor = "black",
             label = ucs$Name,
             labelOptions = labelOptions(
               textsize = "12px",
               style = list(
                 "font-weight" = "bold",
                 padding = "5px")
             ),
             ) %>%

  
  addMarkers(data = estacoes,
             group = "Estações",
             label = estacoes$Name,
             labelOptions = labelOptions(
               textsize = "12px",
               style = list(
                 "font-weight" = "bold",
                 padding = "5px")
             ), icon = list(
               iconUrl = estations,
               iconSize = c(7, 7)
             )
  ) %>% 
  
  addMarkers(data = tradagens,
             group = "Tradagens Positivas",
             label = paste("Tradagem", tradagens$Id, "(Positiva)"),
             labelOptions = labelOptions(
               textsize = "12px",
               style = list(
                 "font-weight" = "bold",
                 padding = "5px")
             ), icon = list(
               iconUrl = trad_icon,
               iconSize = c(7, 7)
             )
  ) %>% 
  
  #hideGroup("Unidades de Coleta") %>% 


  ### CONTROLES ###
  
  
  #Add Search Bar
  addSearchFeatures(targetGroups = c("Centroids", "Unidades de Coleta", "Áreas Escavadas"),
                    options = searchFeaturesOptions(
                      propertyLoc = c("lat","long"),
                      formatData = NULL,
                      filterData = NULL, 
                      moveToLocation = TRUE, 
                      zoom = 25,
                      buildTip = NULL,
                      minLength = 1,
                      initial = FALSE,
                      casesensitive = FALSE,
                      autoType = TRUE,
                      delayType = 50,
                      tooltipLimit = -1,
                      textPlaceholder = "Estrutura/UC/Áreas",
                      position = "topleft",
                      collapsed = FALSE,
                      textErr = "Informação não encontrada!",
                      openPopup = TRUE
                    )) %>% 

  #Layers Control
  addLayersControl(
    position = "topright",
    overlayGroups = c(
      "Curvas de Nível",
      "Unidades de Coleta",
      "Estações",
      "Tradagens Positivas",
      "Fossa/Bolsão/Poço",
      "Fogueira",
      "Buraco de Poste",
      "Artefatos"),
    options = layersControlOptions(collapsed = TRUE)
  ) %>% 
  
  #Legends
  addLegend(
    position = "bottomleft",
    values = c(
      agua,
      fossa,
      bolsao,
      fogueira,
      bposte,
      argila,
      ceramica,
      litico,
      laterita,
      carvao,
      ),
    colors = c(
      "lightblue",
      "#ffb100",
      "#DEB887",
      "#fe0000",
      "black",
      "#ff4601",
      "#8B4513",
      "green",
      "#8B008B",
      "#363636"),
    labels = c(
      "Massa D'água",
      "Fossa",
      "Bolsão/Poço",
      "Fogueira",
      "Buraco de Poste",
      "Argila Queimada",
      "Cerâmica",
      "Lítico",
      "Laterita",
      "Carvão")) %>% 
  
  #Measure widget
  addMeasure(position = "topleft",
             primaryLengthUnit = "meters",
             secondaryLengthUnit = NULL,
             primaryAreaUnit = "sqmeters",
             localization = "pt_BR") %>% 
  
  addResetMapButton() %>%
  

  #Adicionar popup de imagens
  addPopupImages(
    image = est7_img,
    width = 400,
    group = "Est7",
    tooltip = TRUE
  ) %>% 

  addPopupImages(
    image = est8_img,
    width = 400,
    group = "Est8",
    tooltip = TRUE
  ) %>% 
  
  addPopupImages(
    image = est44_img,
    width = 400,
    group = "Est44",
    tooltip = TRUE
  ) %>% 

  addPopupImages(
    image = est210_img,
    width = 400,
    group = "Est210",
    tooltip = TRUE
  )

  ctueapMap
  
  saveWidget(widget = ctueapMap, file = "G:/My Drive/webmap_ctueap/docs/map.html")
  