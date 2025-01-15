const formatNumber = (number) => {
    let numberString = number.toString().replace(".", "");
    console.log("numstring", numberString);
    if (numberString.length > 3) {
      const parts = [];
      const length = numberString.length;
      let count = 0;
      let part = "";
      for (let i = length - 1; i >= 0; i--) {
        if (count < 3 && i >= 0) {
          part += numberString[i];
          count++;
        } else {
          parts.push(part);
          part = numberString[i];
          count = 1;
        }
      }
      if (part.length > 0) parts.push(part);
      console.log("parts", parts);
      const reversed = parts.join(".");
      let normal = "";
      for (let i = reversed.length - 1; i >= 0; i--) {
        normal += reversed[i];
      }
      console.log("normal", normal);
      return normal;
    } else {
      return numberString;
    }
  };
  
  const localeNumber = (number) => {
    return number.toLocaleString("id-ID");
  };
  
  const input = document.querySelector("input");
  input.addEventListener("keyup", (event) => {
    const currentValue = event.target.value.replace(/\./g, "");
    const newValue = Number.parseInt(currentValue).toLocaleString("id-ID");
    console.log(newValue);
    event.target.value = newValue;
  });
  