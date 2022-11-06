module StaffMembers
  def self.home
    admins = all.select {|x| x[:category] == "admin"}
    admins.slice(0,4)
  end
  def self.all
    [
      {
        name: "Mahlahleni N",
        position: "6 Red",
        image: "mr-mahlahleni.jpg",
        category: "junior-teachers",
      },
      {
        name: "Mbayimbayi P",
        position: "7 Red",
        image: "miss-mbayimbayi.jpg",
        category: "junior-teachers",
      },
      {
        name: "Dube B",
        position: "3 Red",
        image: "mrs-dube.jpg",
        category: "junior-teachers",
      },
      {
        name: "Mborera B",
        position: "5 Blue",
        image: "mr-mborera.jpg",
        category: "junior-teachers",
      },
      {
        name: "Muchengeti I",
        position: "Head",
        image: "mr-muchengeti.jpeg",
        category: "admin",
      },
      {
        name: "Marevesa W",
        position: "Deputy Head",
        image: "mr-marevesa.jpeg",
        category: "admin",
      },
      {
        name: "Gadzikwa D",
        position: "TIC",
        image: "mrs-gadzikwa.jpg",
        category: "admin",
      },
      {
        name: "Chibaya S",
        position: "6 Blue",
        image: "mr-chibaya.jpg",
        category: "junior-teachers",
      },
      {
        name: "Chinheva E",
        position: "ECD B Blue",
        image: "miss-chinheva.jpg",
        category: "infant-teachers",
      },
      {
        name: "Ndhlovu T",
        position: "4 Blue",
        image: "miss-ndhlovu.jpg",
        category: "junior-teachers",
      },
      {
        name: "Mandhla G",
        position: "2 Red",
        image: "mrs-mandhla.jpg",
        category: "infant-teachers",
      },
      {
        name: "Muchingami T",
        position: "Assistant Bursar",
        image: "miss-muchingami.jpg",
        category: "staff",
      },
      {
        name: "Kanyemba E",
        position: "4 Red",
        image: "mrs-kanyemba.jpg",
        category: "junior-teachers",
      },
      {
        name: "Mafuya P",
        position: "2 Blue",
        image: "mrs-mafuya.jpg",
        category: "junior-teachers",

      },
      {
        name: "Sandifolo Y",
        position: "Grade 5",
        image: "miss-sandifolo.jpg",
        category: "junior-teachers",
      },
      {
        name: "Mapindure J",
        position: "ECD B Red",
        image: "miss-mapindure.jpg",
        category: "infant-teachers",
      },
      {
        name: "Mbokochena E",
        position: "1 Blue",
        image: "miss-mbokochena.jpg",
        category: "infant-teachers",
      },
      {
        name: "Kona L",
        position: "Sports Director",
        image: "mr-kona.jpg",
        category: "admin",
      },
      {
        name: "Marozveni M",
        position: "Bursar",
        image: "mr-marozveni.jpeg",
        category: "staff",
      },
      {
        name: "Furusa R",
        position: "3 Blue",
        image: "miss-furusa.jpg",
        category: "junior-teachers",
      },
      {
        name: "Mangombe M",
        position: "ICT",
        image: "mr-mamombe.jpeg",
        category: "junior-teachers",
      },
      {
        name: "Mudambo A",
        position: "ECD A Red",
        image: "miss-mudambo.jpg",
        category: "infant-teachers",
      },
      {
        name: "Nhika C",
        position: "ECD A Blue",
        image: "miss-nhika.jpg",
        category: "infant-teachers",
      },
      {
        name: "Nyasulo N",
        position: "5 Blue",
        image: "miss-nyasulo.jpg",
        category: "junior-teachers",
      },
    ]
  end
end
