Rails.application.routes.draw do
  get "student_parents/new"
  get "student_parents/edit"
  resources :parents
  resources :student_attendances
  get "students/index"
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :contact_messages
  resources :online_applications
  resources :schedules
  authenticate :user do
    resources :students
    resources :school_payments, only: %i[edit update]
    resources :assignments, except: :index do
      resources :questions
    end
    resources :private_threads do
      resources :messages, only: :create
    end
    resources :reports
    resource :dashboard, only: :show
    resources :teacher
    resources :student
    resources :classroom_subjects do
      resources :topics
      resources :assignments
    end
    resources :assignments, except: :index do
      resources :assignment_answers, only: %i[update index show create]
    end
    resources :topics do
      resources :lessons
    end
    resources :question_answers, only: :update
    resources :questions do
      resources :question_answers
    end
    resources :classrooms, except: %i[destroy new] do
      resources :messages, only: :create
      member do
        get :chat_room
      end
    end
    resources :subjects
    resources :messages, only: :index
    resources :payments, except: [:edit, :new]
    resources :notifications
    resources :users do
      resources :student_parents
      collection do
        get :profile
        get :teachers_autocomplete
      end
    end
  end

  devise_for :users, path: "auth", controllers: {
                       registrations: "users/registrations",
                     }
  root "home#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
