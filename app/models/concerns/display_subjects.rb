module DisplaySubjects
  def self.home = [
    {
      name: 'Mathematics',
      icon: 'bx-vertical-center'
    },
    {
      name: 'Shona',
      icon: 'bx-file'
    },
    {
      name: 'English Language',
      icon: 'bx-tachometer',
    },
    {
      name: 'Agriculture',
      icon: 'bx-layer',
    },
    {
      name: 'Heritage Studies',
      icon: 'bx-slideshow',
    },
    {
      name: 'Religious Studies',
      icon: 'bx-file',
    },
    {
      name: 'Physical Education',
      icon: 'bx-tennis-ball',
    },
    {
      name: 'Visual Arts',
      icon: 'bx-arch',
    },
  ]
  def self.all = home + []
end
