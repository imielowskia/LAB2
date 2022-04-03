class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy grade zapisz]

  # GET /courses or /courses.json
  def index
    @courses = Course.all
    if params.has_key?(:id)
      @course = Course.find(params[:id])
    else
      @course = Course.new
    end


  end

  # GET /courses/1 or /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  #GET /courses/1/grade
  def grade
    @group = Group.find(params[:group_id])
    @students = @course.groups.find(@group.id).students
    @ile = @students.count

    @grades = Array.new(@students.count)
    for i in 0..@ile-1
      if @course.students.exists?(@students[i].id)
        x = @students[i].course_students.first.grade
      else
        x = 0
      end
      @grades[i]=x
    end
  end

  #POST /courses/1/zapisz
  def zapisz
    @group = Group.find(params[:group_id])
    @students = @course.groups.find(@group.id).students
    @ile = @students.count
    for i in 0..@ile-1
      xocena = params['g_'+i.to_s].to_i
      @students[i].courses.destroy(@course)
      xcs = CourseStudent.new(course_id: @course.id, student_id: @students[i].id, grade: xocena)
      xcs.save!
    end
    redirect_to courses_url, notice: "Zapisano oceny"
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to courses_url, notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to courses_url, notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:nazwa, group_ids: [])
    end
end
