import 'package:CatCultura/models/EventResult.dart';

import '../models/ReviewResult.dart';
class LocalData {

  List<EventResult> get eventLocalData {
    return [
      EventResult(id: "1",
      denominacio: "Evento1",
      descripcio: "descripcio",
      dataInici: "dataInici",
      dataFi: "dataFi",
      horari: "horari",
      codi: "U3d3D3",
      espai: "espai",
      adreca: "adreca",
      localitat: "localitat",
      ubicacio: "ubicacio",
      entrades: "entrades",
      latitud: 41.53557824888737,
      longitud: 2.2161003404898576,
      comarcaIMunicipi: "comarcaIMunicipi",
      nomOrganitzador: "nomOrganitzador",
      idOrganitzador: 1,
      urlOrganitzador: "urlOrganitzador",
      imgApp: "content/dam/agenda/articles/2020/05/07/011/museu-abello-1.jpg/_jcr_content/renditions/cq5dam.web.1280.1280.jpeg",
      imatges: [
        "content/dam/agenda/articles/2020/05/07/011/museu-abello-1.jpg/_jcr_content/renditions/cq5dam.web.1280.1280.jpeg"
      ],
    ),
      EventResult(id: "1",
        denominacio: "Llum BCN",
        descripcio: "Festival d'Arts Lumíniques al Poblenou. 3, 4 i 5 de febrer",
        dataInici: "03-02-2023",
        dataFi: "05-02-2023",
        horari: "NIT",
        codi: "U3d3D3",
        espai: "Diferents espais del Barri del Poblenou",
        adreca: "Poblenoi",
        localitat: "Barcelona",
        ubicacio: "Barcelona, Poblenou",
        entrades: "gratuites",
        latitud: 41.4031659711566,
        longitud: 2.1999894345126325,
        comarcaIMunicipi: "Barcelona",
        nomOrganitzador: "Ajuntament de Barcelona",
        idOrganitzador: 1,
        urlOrganitzador: "urlOrganitzador",
        imgApp: "content/dam/agenda/articles/2023/01/23/049/20230203-llum-bcn.jpg/_jcr_content/renditions/cq5dam.web.1280.1280.jpeg",
        imatges: [
          "content/dam/agenda/articles/2023/01/23/049/20230203-llum-bcn.jpg/_jcr_content/renditions/cq5dam.web.1280.1280.jpeg"
        ],
      )
    ];
  }

  List<ReviewResult> get reviewLocalData {
    return [
      ReviewResult(
          title: "Fantastic",
          review: "Molt bon espectacle i molt recomanable",
          rating: 5,
          eventId: 1,
          reviewId: 1,
          author: "Pepito",
          upvotes: 8,
          date: "2021-01-01"),
      ReviewResult(
          title: "Horrible",
          review: "Una mica decepcionat",
          rating: 2,
          eventId: 1,
          reviewId: 4,
          author: "Fulanito",
          upvotes: 68,
          date: "2021-01-01")
    ];
  }

  void addReview(ReviewResult review) {
    reviewLocalData.add(review);
  }

  List<EventResult> get rutaCulturalLocalData {
    return [
      EventResult(id: "1",
        denominacio: "Evento1",
        descripcio: "descripcio",
        dataInici: "dataInici",
        dataFi: "dataFi",
        horari: "horari",
        codi: "U3d3D3",
        espai: "espai",
        adreca: "adreca",
        localitat: "localitat",
        ubicacio: "ubicacio",
        entrades: "entrades",
        latitud: 42.5237744462414,
        longitud: 0.8340243039750936,
        comarcaIMunicipi: "comarcaIMunicipi",
        nomOrganitzador: "nomOrganitzador",
        idOrganitzador: 1,
        urlOrganitzador: "urlOrganitzador",
        imgApp: "content/dam/agenda/articles/2020/05/07/011/museu-abello-1.jpg/_jcr_content/renditions/cq5dam.web.1280.1280.jpeg",
        imatges: [
          "content/dam/agenda/articles/2020/05/07/011/museu-abello-1.jpg/_jcr_content/renditions/cq5dam.web.1280.1280.jpeg"
        ],
      ),
      EventResult(id: "1",
        denominacio: "Evento2",
        descripcio: "descripcio",
        dataInici: "dataInici",
        dataFi: "dataFi",
        horari: "horari",
        codi: "U3d3D3",
        espai: "espai",
        adreca: "adreca",
        localitat: "localitat",
        ubicacio: "ubicacio",
        entrades: "entrades",
        latitud: 42.520848342554935,
        longitud: 0.8362162010901544,
        comarcaIMunicipi: "comarcaIMunicipi",
        nomOrganitzador: "nomOrganitzador",
        idOrganitzador: 1,
        urlOrganitzador: "urlOrganitzador",
        imgApp: "content/dam/agenda/articles/2020/05/07/011/museu-abello-1.jpg/_jcr_content/renditions/cq5dam.web.1280.1280.jpeg",
        imatges: [
          "content/dam/agenda/articles/2020/05/07/011/museu-abello-1.jpg/_jcr_content/renditions/cq5dam.web.1280.1280.jpeg"
        ],
      ),
      EventResult(id: "1",
        denominacio: "Evento3",
        descripcio: "descripcio",
        dataInici: "dataInici",
        dataFi: "dataFi",
        horari: "horari",
        codi: "U3d3D3",
        espai: "espai",
        adreca: "adreca",
        localitat: "localitat",
        ubicacio: "ubicacio",
        entrades: "entrades",
        latitud: 42.517638048068356,
        longitud: 0.8484941572915711,
        comarcaIMunicipi: "comarcaIMunicipi",
        nomOrganitzador: "nomOrganitzador",
        idOrganitzador: 1,
        urlOrganitzador: "urlOrganitzador",
        imgApp: "content/dam/agenda/articles/2020/05/07/011/museu-abello-1.jpg/_jcr_content/renditions/cq5dam.web.1280.1280.jpeg",
        imatges: [
          "content/dam/agenda/articles/2020/05/07/011/museu-abello-1.jpg/_jcr_content/renditions/cq5dam.web.1280.1280.jpeg"
        ],
      ),
    ];
  }
}