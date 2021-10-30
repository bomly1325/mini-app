<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAmortizationScheduleTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('payments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('loan_id')->constrained('loans');
            $table->date('payment_date');
            $table->decimal('payment', 10);
            $table->decimal('principal', 10);
            $table->decimal('interest', 10);
            $table->decimal('total_interest', 10);
            $table->decimal('balance', 10);
            $table->boolean('paid')->default(false);
            $table->dateTime('paid_date')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('payments');
    }
}
