<?php

namespace App\Repositories;

use Illuminate\Database\Eloquent\Model;

abstract class Repository
{
    protected $model;

    public function __construct()
    {
        $this->model = app($this->getModel());
    }

    public abstract function getModel();

    public function getQuery()
    {
        return $this->model->query();
    }

    public function find($id)
    {
        return $this->model->find($id);
    }

    public function findBy($fieldName, $fieldValue)
    {
        return $this->model->firstWhere($fieldName, $fieldValue);
    }

    public function create($attributes = [])
    {
        return $this->model->create($attributes);
    }

    public function update($id, $attributes = [])
    {
        $result = $this->find($id);
        if ($result) {
            $result->update($attributes);
            return $result;
        }
        return false;
    }

    public function delete($id)
    {
        $result = $this->find($id);
        if ($result) {
            $result->delete();

            return true;
        }
        return false;
    }
}
