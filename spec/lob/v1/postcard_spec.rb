require "spec_helper"

describe Lob::V1::Postcard do

  before :each do
    @sample_address_params = {
      name:    "TestAddress",
      email:   "test@test.com",
      address_line1: "123 Test Street",
      address_line2: "Unit 199",
      city:    "Mountain View",
      state:   "CA",
      country: "US",
      zip:     94085
    }

    @sample_postcard_params = {
      description:    "TestPostcard",
      message: "Sample postcard message"
    }
  end

  subject { Lob(api_key: ENV["LOB_API_KEY"]) }

  describe "list" do
    it "should list postcards" do
      assert subject.postcards.list["object"] == "list"
    end
  end


  describe "create" do
    it "should create a postcard with address_id" do
      new_address = subject.addresses.create @sample_address_params

      result = subject.postcards.create(
        name: @sample_postcard_params[:name],
        to: new_address["id"],
        message: @sample_postcard_params[:message],
        front: "https://lob.com/postcardfront.pdf",
      )

      result["name"].must_equal(@sample_postcard_params[:name])
    end

    it "should create a postcard with to address params" do
      result = subject.postcards.create(
        name: @sample_postcard_params[:name],
        to: @sample_address_params,
        message: @sample_postcard_params[:message],
        front: "https://lob.com/postcardfront.pdf"
      )

      result["name"].must_equal(@sample_postcard_params[:name])
    end

    it "should create a postcard with from address params" do
      new_address = subject.addresses.create @sample_address_params

      result = subject.postcards.create(
        name: @sample_postcard_params[:name],
        to: new_address["id"],
        from: @sample_address_params,
        message: @sample_postcard_params[:message],
        front: "https://lob.com/postcardfront.pdf"
      )

      result["name"].must_equal(@sample_postcard_params[:name])
    end

    it "should create a postcard with front and back as urls" do
      new_address = subject.addresses.create @sample_address_params

      result = subject.postcards.create(
        name: @sample_postcard_params[:name],
        to: new_address["id"],
        front: "https://lob.com/postcardfront.pdf",
        back:  "https://lob.com/postcardback.pdf"
      )

      result["name"].must_equal(@sample_postcard_params[:name])
    end


    it "should create a postcard with front and back as PDFs" do
      new_address = subject.addresses.create @sample_address_params

      result = subject.postcards.create(
        name: @sample_postcard_params[:name],
        to: new_address["id"],
        front: File.new(File.expand_path("../../../samples/postcardfront.pdf", __FILE__)),
        back: File.new(File.expand_path("../../../samples/postcardback.pdf", __FILE__))
      )

      result["name"].must_equal(@sample_postcard_params[:name])
    end

  end


  describe "find" do
    it "should find a postcard" do
      new_address = subject.addresses.create @sample_address_params

      new_postcard = subject.postcards.create(
        name: @sample_postcard_params[:name],
        to: new_address["id"],
        front: File.new(File.expand_path("../../../samples/postcardfront.pdf", __FILE__)),
        back: File.new(File.expand_path("../../../samples/postcardback.pdf", __FILE__))
      )

      result  = subject.postcards.find(new_postcard["id"])
      result["name"].must_equal(@sample_postcard_params[:name])
    end
  end

end
