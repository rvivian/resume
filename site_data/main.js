window.addEventListener('DOMContentLoaded', (event) =>{
    getVisitCount();
})

const functionApiUrl = 'https://rv-res-test.azurewebsites.net/api/counter';
const localApiUrl = 'http://localhost:7071/api/Counter';

const getVisitCount = () => {
    let count = 30;
    fetch(localApiUrl).then(response => {
        return response.json()
    }).then(response =>{
        console.log("Website called function API.");
        console.log(response.Count)
        count = response.Count;
        document.getElementById("counter").innerText = count;
    }).catch(function(error){
        console.log(error);
    });
    return count;
}