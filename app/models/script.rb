class Script < ApplicationRecord
    has_one_attached :multi_page_pdf
    has_many :single_page_pdfs, dependent: :destroy
    has_one_attached :combined_pdf
    def split_multi_page_pdf_into_single_pages
        return unless multi_page_pdf.attached?
        pdf_data = multi_page_pdf.download
        # Create a StringIO object with the file data
        io_object = StringIO.new(pdf_data)
        # Pass the StringIO object to PDF::Reader.new
        reader = PDF::Reader.new(io_object)
        reader.pages.each_with_index do |page, index|
            single_page_pdf = SinglePagePdf.create(script: self, page_number: index + 1)
            single_page_pdf.file.attach(io: StringIO.new(page.text), filename: "page_#{index + 1}.pdf")
        end
    end
end



