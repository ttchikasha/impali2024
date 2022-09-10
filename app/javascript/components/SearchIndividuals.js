import React, { useEffect, useState } from "react";
import Rails from "@rails/ujs";
import Select from "react-select";

function SearchIndividuals() {
  const [options, setOptions] = useState([]);
  const [selectedOptions, setSelectedOptions] = useState([]);
  const url = "/users/staff_autocomplete";

  const search = () =>
    Rails.ajax({
      type: "GET",
      url,
      success: function (data) {
        console.log("Retrieved Data");
        console.log(data);
        let d = data.map((d) => {
          return {
            value: d.id,
            label: d.first_name + " " + d.last_name,
          };
        });
        setOptions(d);
      },
      error: function (data) {
        console.log("Error: " + data);
      },
    });

  useEffect(
    () =>
      setTimeout(() => {
        search();
      }, 1000),
    []
  );

  const updateSelection = (selected) => {
    let d = selected.map((s) => s.value);
    setSelectedOptions(d);
  };

  return (
    <>
      <Select
        placeholder="Start typing to search"
        name="individuals"
        isMulti
        options={options}
        onChange={updateSelection}
      />
      <div style={{ display: "none" }}>
        <input
          multiple="multiple"
          type="hidden"
          name="notification[user_ids][]"
          id="notification_user_ids"
        />
        {selectedOptions.map((o) => (
          <input
            class="form-check-input"
            type="checkbox"
            value={o}
            checked={true}
            name="notification[user_ids][]"
            id={"notification_user_ids_" + o}
          ></input>
        ))}
      </div>
    </>
  );
}

export default SearchIndividuals;
