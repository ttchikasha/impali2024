import React, { useState } from "react";

function UpdateResult({ resultId, total }) {
  const [open, setOpen] = useState(false);
  const [mark, setMark] = useState(null);

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log(
      `Update: ${mark} out of ${total} for Result with id = ${resultId}`
    );
    setOpen(false);
  };

  return (
    <>
      {!open && (
        <button onClick={() => setOpen(true)} className="btn-sm">
          Update
        </button>
      )}
      {open && (
        <div className="input-group">
          <input
            value={mark}
            onChange={(e) => setMark(e.target.value)}
            type="number"
            min={0}
            max={total}
            className="form-control"
          />
          <span className="input-group-text">/ {total}</span>
          <button
            onClick={handleSubmit}
            class="btn btn-outline-success"
            type="button"
          >
            Submit
          </button>
        </div>
      )}
    </>
  );
}

export default UpdateResult;
