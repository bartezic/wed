json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :id, :partner_id, :subject, :name, :email, :msg
  json.url feedback_url(feedback, format: :json)
end
