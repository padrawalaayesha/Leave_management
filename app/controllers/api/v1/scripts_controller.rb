class Api::V1::ScriptsController < ApplicationController

  def create
    script = Script.new(script_params)
    script.multi_page_pdf.attach(params[:multi_page_pdf])
    if script.save
      script.split_multi_page_pdf_into_single_pages
      render json: {message: "Multi-page PDF split into single-page PDFs"}, status: :ok
    else
      render json: {error: script.errors.full_messages}, status: :unprocessable_entity
    end
  end
  

  private
  
  def script_params
    params.require(:script).permit(:title)
  end

end