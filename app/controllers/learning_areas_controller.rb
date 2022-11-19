class LearningAreasController < ApplicationController
  def index
    @sports = [
      {
        name: "Soccer",
        icon: "bxl-dribbble",
      },
      {
        name: "Netball",
        icon: "bx-aperture",
      },
      {
        name: "Volleyball",
        icon: "bxs-bullseye",
      },
      {
        name: "Basketball",
        icon: "bxs-basketball",
      },
      {
        name: "Tennis",
        icon: "bx-tennis-ball",
      },
      {
        name: "Handball",
        icon: "bxs-baseball",
      },
      {
        name: "Hockey",
        icon: "bx-bowling-ball",
      },
      {
        name: "Chess",
        icon: "bxs-checkbox",
      },
      {
        name: "Athletics",
        icon: "bx-body",
      },
    ]
    @extra = [
      "Quiz",
      "Debate",
      "Music",
      "Drum majoretees",
      "Choreography",
      "Traditional Dance",
      "Perccusion",
      "Marimba",
    ]
    @junior_subjects = DisplaySubjects.juniors
    @infant_subjects = DisplaySubjects.infants
  end
end
