ActiveAdmin.register Category do
  form do |f|
    f.inputs do
      f.input :slug
    end
    f.globalize_inputs :translations do |lf|
      lf.inputs do
        lf.input :name
        lf.input :name_sing

        lf.input :locale, :as => :hidden
      end
    end
    f.actions
  end
end
