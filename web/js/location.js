document.addEventListener("DOMContentLoaded", function () {
    loadProvinces();
});

let locationData = {}; // Biến chứa dữ liệu địa phương

// Load danh sách tỉnh/thành phố
async function loadProvinces() {
    try {
        const response = await fetch("js/tree.json");
        locationData = await response.json();

        const provinceSelect = document.getElementById("province");
      
        for (const province of Object.values(locationData)) {
            const option = document.createElement("option");
            option.value = province.name_with_type; // Cả value và textContent đều là name_with_type
            option.textContent = province.name_with_type;
            provinceSelect.appendChild(option);
        }
    } catch (error) {
        console.error("Lỗi tải dữ liệu:", error);
    }
}



// Load danh sách quận/huyện theo tỉnh đã chọn
function loadDistricts() {
    const provinceName = document.getElementById("province").value;
    const districtSelect = document.getElementById("district");
    districtSelect.innerHTML = '<option value="">Chọn quận/huyện</option>';

    const province = Object.values(locationData).find(p => p.name_with_type === provinceName);
    if (!province || !province["quan-huyen"])
        return;

    for (const district of Object.values(province["quan-huyen"])) {
        const option = document.createElement("option");
        option.value = district.name_with_type; // Giá trị gửi đi là name_with_type
        option.textContent = district.name_with_type;
        districtSelect.appendChild(option);
    }
}


// Load danh sách xã/phường theo quận/huyện đã chọn
function loadWards() {
    const provinceName = document.getElementById("province").value;
    const districtName = document.getElementById("district").value;
    const wardSelect = document.getElementById("ward");
    wardSelect.innerHTML = '<option value="">Chọn xã/phường</option>';

    const province = Object.values(locationData).find(p => p.name_with_type === provinceName);
    if (!province)
        return;

    const district = Object.values(province["quan-huyen"]).find(d => d.name_with_type === districtName);
    if (!district || !district["xa-phuong"])
        return;

    for (const ward of Object.values(district["xa-phuong"])) {
        const option = document.createElement("option");
        option.value = ward.name_with_type; // Giá trị gửi đi là name_with_type
        option.textContent = ward.name_with_type;
        wardSelect.appendChild(option);
    }
}


