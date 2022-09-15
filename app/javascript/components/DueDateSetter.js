import React, { useState } from "react";
import PropTypes from "prop-types";
import DatePicker from "react-date-picker";
import Rails from "@rails/ujs";

function DueDateSetter({ userId, dueDate }) {
  const [value, setValue] = useState(dueDate ? new Date(dueDate) : undefined);
  const [disabled, setDisabled] = useState(true);
  const [editMode, setEditMode] = useState(false);

  const pardonStudent = () => {
    let data = new FormData();
    data.append("user_id", userId);
    data.append("due_date", value);
    Rails.ajax({
      type: "POST",
      url: "/pardon_students/pardon",
      data,
      success: function (data) {
        setValue(new Date(data.due_date));
        setEditMode(false);
      },
    });
  };

  const onChange = (value) => {
    if (value == null) {
      setDisabled(true);
    } else {
      setDisabled(false);
    }

    setValue(value);
  };

  const renderBtn = (text) => (
    <button
      onClick={() => setEditMode(true)}
      className="ms-3 btn btn-sm btn-success"
    >
      {text}
    </button>
  );

  return (
    <div>
      <br />
      <hr />

      {!value && !editMode && (
        <>
          <p>Give Grace Period {renderBtn("Give")}</p>
        </>
      )}

      {value && !editMode && (
        <div className="d-flex align-items-start">
          <p className="small fw-bold align-self-center">
            {value && <p> Pardoned up to {value.toDateString()}</p>}
          </p>
          {renderBtn("Edit")}
        </div>
      )}

      {editMode && (
        <>
          <h6>Pardon Student:</h6>
          <div className="d-flex">
            <button
              onClick={() => setEditMode(false)}
              className="btn btn-danger btn-sm"
            >
              Cancel
            </button>
            <span className="mx-2"></span>
            <DatePicker
              minDate={new Date()}
              onChange={onChange}
              value={value}
            />
            <span className="mx-2"></span>
            <button
              disabled={disabled}
              onClick={() => pardonStudent()}
              className="btn btn-success btn-sm"
            >
              Pardon
            </button>
          </div>
        </>
      )}
    </div>
  );
}

DueDateSetter.propTypes = {
  userId: PropTypes.node,
  dueDate: PropTypes.string,
};

export default DueDateSetter;
