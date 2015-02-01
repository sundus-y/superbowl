class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]

  # GET /results
  # GET /results.json
  def index
    @se_t = Team.first
    @gb_t = Team.last
    @table_hash = {}
    @table_max_hash = {}
    r_se = Result.joins(:game).where(team:@se_t,games:{desc:'gnb'})
    r_gb = Result.joins(:game).where(team:@gb_t,games:{desc:'gnb'})
    @table_hash['gb'] = get_result_table(r_gb, r_se)
    @table_max_hash['gb'] = get_table_max(@table_hash['gb'])
    r_se = Result.joins(:game).where(team:@se_t,games:{desc:'sea'})
    r_gb = Result.joins(:game).where(team:@gb_t,games:{desc:'sea'})
    @table_hash['se'] = get_result_table(r_gb, r_se)
    @table_max_hash['se'] = get_table_max(@table_hash['se'])
    r_se = Result.joins(:game).where(team:@se_t,games:{desc:'all'})
    r_gb = Result.joins(:game).where(team:@gb_t,games:{desc:'all'})
    @table_hash['all'] = get_result_table(r_gb, r_se)
    @table_max_hash['all'] = get_table_max(@table_hash['all'])

  end

  def get_result_table(r_gb, r_se)
    q_1_table = Array.new(10) { Array.new(10, 0) }
    q_2_table = Array.new(10) { Array.new(10, 0) }
    q_3_table = Array.new(10) { Array.new(10, 0) }
    q_4_table = Array.new(10) { Array.new(10, 0) }
    q_t_table = Array.new(10) { Array.new(10, 0) }
    table = build_table(q_1_table, q_2_table, q_3_table, q_4_table, q_t_table)
    r_se.zip(r_gb).each do |se, gb|
      row = gb.points.to_s.last.to_i
      col = se.points.to_s.last.to_i
      table[se.quarter.to_s][row][col] += 1
      table['5'][row][col] += 1
    end
    table
  end

  def build_table(t1,t2,t3,t4,t5)
    {'1' => t1,'2' => t2,'3' => t3,'4' => t4,'5' => t5}
  end

  def get_table_max(table)
    {'1' => table.values[0].reduce(&:+).max,
     '2' => table.values[1].reduce(&:+).max,
     '3' => table.values[2].reduce(&:+).max,
     '4' => table.values[3].reduce(&:+).max,
     '5' => table.values[4].reduce(&:+).max
    }
  end

  # GET /results/1
  # GET /results/1.json
  def show
  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results
  # POST /results.json
  def create
    @result = Result.new(result_params)

    respond_to do |format|
      if @result.save
        format.html { redirect_to @result, notice: 'Result was successfully created.' }
        format.json { render :show, status: :created, location: @result }
      else
        format.html { render :new }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /results/1
  # PATCH/PUT /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to @result, notice: 'Result was successfully updated.' }
        format.json { render :show, status: :ok, location: @result }
      else
        format.html { render :edit }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result.destroy
    respond_to do |format|
      format.html { redirect_to results_url, notice: 'Result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params.require(:result).permit(:game, :team, :quarter, :points)
    end
end
