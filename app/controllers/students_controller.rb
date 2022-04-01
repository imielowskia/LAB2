class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy grade zapisz]

  # GET /students or /students.json
  def index
    @students = Student.all
    if params.has_key?(:id)
      @student = Student.find(params[:id])
    else
      @student = Student.new
    end
  end

  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
    id = @student.id
    respond_to do |format|
      format.html { redirect_to students_url(id: id)  }
      format.json { head :no_content }
    end
  end

  # GET /students/1/grade
  def grade
    @course = Course.find(params[:course_id])
    unless @student.courses.exists?(id: @course.id)
      @student.courses<<@course
    end
    @cs = @student.course_students.where(course_id: @course.id).first.grade
  end

  # POST /students
  def zapisz
    @course = Course.find(params[:course_id])
    @grade = params[:grade].to_i
    xcs = @student.course_students.where(course_id: @course.id).first
    xcs.grade = @grade
    xcs.save!
    redirect_to students_url, notice: "Zapisano ocenę: "+@grade.to_s

  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to students_url, notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to students_url, notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:imie, :nazwisko, :indeks, :group_id, course_students_attributes:[:grade])
    end
end
